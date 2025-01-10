//
//  BluetoothCoordinatorProtocol.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation

@MainActor
protocol BluetoothCoordinatorProtocol {
    func showDeviceDetails(device: BluetoothDevice)
}
