//
//  AppFactory.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import LanScanner

final class AppFactory {
    private lazy var bluetoothService = BluetoothService()
    
    func makeBluetoothService() -> BluetoothService {
        bluetoothService
    }
}
