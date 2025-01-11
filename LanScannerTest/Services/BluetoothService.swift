//
//  BluetoothService.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import CoreBluetooth
import Combine

final class BluetoothService: NSObject, ObservableObject {
    @Published private(set) var discoveredDevices: [BluetoothDevice] = []
    @Published private(set) var isBluetoothOn: Bool = false
    @Published private(set) var errorMessage: String?
    
    private var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        guard centralManager.state == .poweredOn else {
            updateState(with: centralManager.state)
            return
        }
        discoveredDevices = []
        centralManager.scanForPeripherals(
            withServices: nil,
            options: [CBCentralManagerScanOptionAllowDuplicatesKey: false]
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.centralManager.stopScan()
        }
    }
    
    func stopScanning() {
        centralManager.stopScan()
    }
    
    private func updateState(with state: CBManagerState) {
        let bluetoothState = BluetoothState.from(state)
        isBluetoothOn = (state == .poweredOn)
        errorMessage = bluetoothState.rawValue.isEmpty ? nil : bluetoothState.rawValue
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothService: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        updateState(with: central.state)
    }
    
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String: Any],
        rssi RSSI: NSNumber
    ) {
        let status = determineStatus(for: peripheral, advertisementData: advertisementData)
        
        let device = BluetoothDevice(
            id: peripheral.identifier,
            name: peripheral.name ?? "Неизвестное устройство",
            uuid: peripheral.identifier.uuidString,
            rssi: RSSI.intValue,
            status: status
        )
        
        if !discoveredDevices.contains(where: { $0.id == device.id }) {
            DispatchQueue.main.async {
                self.discoveredDevices.append(device)
            }
        }
    }
    
    private func determineStatus(for peripheral: CBPeripheral, advertisementData: [String: Any]) -> String {
        switch peripheral.state {
        case .connected:
            return "Подключено"
        case .connecting:
            return "Подключение в процессе"
        case .disconnected:
            if let isConnectable = advertisementData[CBAdvertisementDataIsConnectable] as? Bool {
                return isConnectable ? "Доступно для подключения" : "Недоступно для подключения"
            }
            return "Неизвестное состояние"
        case .disconnecting:
            return "Отключение"
        @unknown default:
            return "Неизвестное состояние"
        }
    }
}

enum BluetoothState: String {
    case poweredOn = ""
    case poweredOff = "Bluetooth выключен."
    case unauthorized = "Приложение не авторизовано для использования Bluetooth."
    case unsupported = "Устройство не поддерживает Bluetooth."
    case resetting = "Bluetooth перезагружается."
    case unknown = "Состояние Bluetooth неизвестно."
    case newState = "Доступно новое состояние Bluetooth."
    
    static func from(_ state: CBManagerState) -> BluetoothState {
        switch state {
        case .poweredOn: return .poweredOn
        case .poweredOff: return .poweredOff
        case .unauthorized: return .unauthorized
        case .unsupported: return .unsupported
        case .resetting: return .resetting
        case .unknown: return .unknown
        @unknown default: return .newState
        }
    }
}
