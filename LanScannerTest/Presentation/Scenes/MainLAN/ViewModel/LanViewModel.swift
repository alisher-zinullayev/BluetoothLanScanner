//
//  ScanViewModel.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import Combine
import LanScanner
import Network
import SwiftUI

final class LanViewModel: BaseViewModel {
    @Published var connectedDevices: [LanDevice] = []
    @Published var progress: CGFloat = 0.0
    @Published var title: String = "Сканирование LAN..."
    @Published var showToast: Bool = false
    @Published var toastMessage: String = ""
    @Published var scanDuration: Double = 15.0
    @Published var searchText: String = ""
    @Published var isScanning: Bool = false
    
    private var lastProgressUpdate = Date()
    private var scanner: LanScanner?
    private var monitor: NWPathMonitor?
    private let networkQueue = DispatchQueue(label: "NetworkMonitor")
    private var cancellables = Set<AnyCancellable>()
    private let coordinator: LanCoordinatorProtocol

    init(coordinator: LanCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init()
        setupNetworkMonitor()
        setupSearch()
    }
    
    @MainActor func showDeviceDetails(device: LanDevice) {
        coordinator.showDeviceDetails(device: device)
    }

    deinit {
        monitor?.cancel()
    }

    private func setupNetworkMonitor() {
        monitor = NWPathMonitor(requiredInterfaceType: .wifi)
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if path.status == .satisfied {
                    self.startScan()
                } else {
                    self.handleError("Нет доступа к локальной сети.")
                    self.stopScan()
                }
            }
        }
        monitor?.start(queue: networkQueue)
    }
    
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filterDevices(searchText: searchText)
            }
            .store(in: &cancellables)
    }
    
    func startScan() {
        guard scanner == nil else { return }

        connectedDevices.removeAll()
        progress = 0.0
        title = "Сканирование LAN..."
        isScanning = true
        
        scanner = LanScanner(delegate: self)
        scanner?.start()

        DispatchQueue.main.asyncAfter(deadline: .now() + scanDuration) { [weak self] in
            self?.stopScan()
        }
    }
    
    func reload() {
        stopScan()
        startScan()
    }

    func stopScan() {
        guard isScanning else { return }
        scanner?.stop()
        scanner = nil
        isScanning = false
        withAnimation(.linear(duration: 0.1)) {
            self.progress = 1.0
        }
        title = "Сканирование завершено"
        
        self.handleCompletion("Найдено устройств: \(connectedDevices.count)")

        saveToCoreData()
    }

    private func filterDevices(searchText: String) { }
    
    func showToast(message: String) {
        toastMessage = message
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showToast = false
            }
        }
    }
}

extension LanViewModel: LanScannerDelegate {
    func lanScanHasUpdatedProgress(_ progress: CGFloat, address: String) {
        DispatchQueue.main.async {
            let now = Date()
            guard now.timeIntervalSince(self.lastProgressUpdate) > 0.05 else { return }
            self.lastProgressUpdate = now

            withAnimation(.linear(duration: 0.15)) {
                self.progress = progress
            }
            self.title = address
        }
    }

    func lanScanDidFindNewDevice(_ device: LanDevice) {
        DispatchQueue.main.async {
            if !self.connectedDevices.contains(where: { $0.id == device.id }) {
                self.connectedDevices.append(device)
            }
        }
    }

    func lanScanDidFinishScanning() {
        DispatchQueue.main.async {
            withAnimation(.linear(duration: 0.1)) {
                self.progress = 1.0
            }

            self.stopScan()
            self.showToast(message: "Сканирование завершено. Найдено \(self.connectedDevices.count) устройств.")
        }
    }
}

// MARK: - Core Data Logic
extension LanViewModel {
    private func saveToCoreData() {
        let session = CoreDataManager.shared.createScanSession()
        for device in connectedDevices {
            CoreDataManager.shared.saveLanDevice(
                id: UUID(),
                ipAddress: device.ipAddress,
                name: device.name,
                brand: device.brand,
                mac: device.mac,
                session: session
            )
        }
    }
}
