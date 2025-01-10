// ScanViewModel.swift
import Foundation
import Combine
import LanScanner
import Network
import SwiftUI

class LanViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var connectedDevices: [LanDevice] = []
    @Published var progress: CGFloat = 0.0
    @Published var title: String = "Сканирование LAN..."
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var showToast: Bool = false
    @Published var toastMessage: String = ""
    
    @Published var scanDuration: Double = 30.0 // По умолчанию 30 секунд
    @Published var searchText: String = ""
    
    // Дополнительные Published свойства для ошибок
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var isScanning: Bool = false
    
    // MARK: - Private Properties
    private var scanner: LanScanner?
    private var monitor: NWPathMonitor?
    private let networkQueue = DispatchQueue(label: "NetworkMonitor")
    
    private var cancellables = Set<AnyCancellable>()
    
    
    private let coordinator: LanCoordinatorProtocol
    // MARK: - Init
    init(coordinator: LanCoordinatorProtocol) {
        self.coordinator = coordinator
        setupNetworkMonitor()
        setupSearch()
    }
    
    @MainActor func showDeviceDetails(device: LanDevice) {
            coordinator.showDeviceDetails(device: device)
        }
    
    deinit {
        monitor?.cancel()
    }
    
    // MARK: - Network Monitoring
    private func setupNetworkMonitor() {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    // Сеть доступна, можно начать сканирование
                    self?.startScan()
                } else {
                    // Сеть недоступна, показать алерт
                    self?.alertMessage = "Нет доступа к локальной сети."
                    self?.showAlert = true
                    self?.stopScan()
                }
            }
        }
        monitor?.start(queue: networkQueue)
    }
    
    // MARK: - Search Setup
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filterDevices(searchText: searchText)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Scanning Methods
    func startScan() {
        // Предотвращаем запуск нескольких сканирований одновременно
        guard scanner == nil else { return }
        
        // Сброс предыдущих данных
        connectedDevices.removeAll()
        progress = 0.0
        title = "Сканирование LAN..."
        isScanning = true
        
        // Инициализация сканера и запуск сканирования
        scanner = LanScanner(delegate: self)
        scanner?.start()
        
        // Устанавливаем таймер для автоматической остановки сканирования
        DispatchQueue.main.asyncAfter(deadline: .now() + scanDuration) { [weak self] in
            self?.stopScan()
        }
    }
    
    func reload() {
        stopScan()
        startScan()
    }
    
    func stopScan() {
        scanner?.stop()
        scanner = nil
        isScanning = false
        title = "Сканирование завершено"
        alertMessage = "Найдено устройств: \(connectedDevices.count)"
        showAlert = true
    }
    
    // MARK: - Filtering Method
    private func filterDevices(searchText: String) {
        // Фильтрация осуществляется во View через filteredDevices
        // Дополнительная логика может быть реализована здесь, если необходимо
    }
    
    // MARK: - Toast Method
    func showToast(message: String) {
        toastMessage = message
        showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showToast = false
            }
        }
    }
    
    // MARK: - Error Handling
    func showError(message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}

extension LanViewModel: LanScannerDelegate {
    func lanScanHasUpdatedProgress(_ progress: CGFloat, address: String) {
        DispatchQueue.main.async {
            self.progress = progress
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
            self.stopScan()
            self.showToast(message: "Сканирование завершено. Найдено \(self.connectedDevices.count) устройств.")
        }
    }
    
    // Если протокол LanScannerDelegate поддерживает обработку ошибок, добавьте метод:
    /*
    func lanScanDidFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.showError(message: error.localizedDescription)
        }
    }
    */
}

