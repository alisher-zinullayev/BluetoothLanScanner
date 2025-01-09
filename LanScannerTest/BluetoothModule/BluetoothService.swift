//
//  BluetoothService.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import CoreBluetooth
import Combine

class BluetoothService: NSObject, ObservableObject {
    @Published var discoveredDevices: [BluetoothDevice] = []
    @Published var isBluetoothOn: Bool = false
    @Published var errorMessage: String? = nil
    
    private var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        guard centralManager.state == .poweredOn else {
            self.errorMessage = "Bluetooth не включен."
            return
        }
        discoveredDevices = []
        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
        
        // Автоматическое остановка сканирования через 15 секунд
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.centralManager.stopScan()
            // Здесь мы не устанавливаем errorMessage, это должно делаться в ViewModel
        }
    }
}

extension BluetoothService: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            isBluetoothOn = true
            errorMessage = nil
        case .poweredOff:
            isBluetoothOn = false
            errorMessage = "Bluetooth выключен."
        case .unauthorized:
            isBluetoothOn = false
            errorMessage = "Приложение не авторизовано для использования Bluetooth."
        case .unsupported:
            isBluetoothOn = false
            errorMessage = "Устройство не поддерживает Bluetooth."
        case .resetting:
            isBluetoothOn = false
            errorMessage = "Bluetooth перезагружается."
        case .unknown:
            isBluetoothOn = false
            errorMessage = "Состояние Bluetooth неизвестно."
        @unknown default:
            isBluetoothOn = false
            errorMessage = "Доступно новое состояние Bluetooth."
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let device = BluetoothDevice(
            id: peripheral.identifier,
            name: peripheral.name ?? "Неизвестное устройство",
            uuid: peripheral.identifier.uuidString,
            rssi: RSSI.intValue,
            status: "Обнаружено"
        )
        
        if !discoveredDevices.contains(where: { $0.id == device.id }) {
            DispatchQueue.main.async {
                self.discoveredDevices.append(device)
            }
        }
    }
}
