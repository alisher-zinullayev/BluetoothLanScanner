//
//  BluetoothDevice.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import CoreBluetooth

struct BluetoothDevice: Identifiable {
    let id: UUID
    let name: String
    let uuid: String
    let rssi: Int
    let status: String
}
