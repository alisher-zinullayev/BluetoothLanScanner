//
//  BluetoothViewModel.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import Combine

final class BluetoothViewModel: ObservableObject {
    @Published var bluetoothDevices: [BluetoothDevice] = []
    @Published var isScanning: Bool = false
    @Published var alertItem: BluetoothScanAlert? = nil
    @Published var searchText: String = ""

    private var bluetoothService: BluetoothService
    private var coordinator: BluetoothCoordinatorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    var filteredDevices: [BluetoothDevice] {
        if searchText.isEmpty {
            return bluetoothDevices
        } else {
            return bluetoothDevices.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    init(coordinator: BluetoothCoordinatorProtocol, bluetoothService: BluetoothService) {
        self.coordinator = coordinator
        self.bluetoothService = bluetoothService
        setupBindings()
    }

    private func setupBindings() {
        bluetoothService.$discoveredDevices
            .receive(on: DispatchQueue.main)
            .assign(to: \.bluetoothDevices, on: self)
            .store(in: &cancellables)

        bluetoothService.$isBluetoothOn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isOn in
                if !isOn {
                    if let message = self?.bluetoothService.errorMessage {
                        self?.alertItem = .error(message)
                    }
                }
            }
            .store(in: &cancellables)

        bluetoothService.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                if let message = message {
                    self?.alertItem = .error(message)
                }
            }
            .store(in: &cancellables)
    }

    func startScan() {
        guard bluetoothService.isBluetoothOn else {
            if let message = bluetoothService.errorMessage {
                self.alertItem = .error(message)
            }
            return
        }
        isScanning = true
        alertItem = nil
        bluetoothService.startScanning()

        DispatchQueue.main.asyncAfter(deadline: .now() + 15) { [weak self] in
            self?.isScanning = false
            self?.saveToCoreData()
        }
    }

    private func saveToCoreData() {
        let session = CoreDataManager.shared.createScanSession()
        for device in bluetoothDevices {
            CoreDataManager.shared.saveBluetoothDevice(
                id: UUID(),
                name: device.name,
                uuid: device.uuid,
                rssi: Int32(device.rssi),
                status: device.status,
                session: session
            )
        }
    }

    @MainActor func showDeviceDetails(device: BluetoothDevice) {
        coordinator.showDeviceDetails(device: device)
    }
}
