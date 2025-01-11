//
//  BluetoothDevice.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import CoreBluetooth

struct BluetoothDevice: Identifiable, Equatable, Hashable {
    let id: UUID
    let name: String
    let uuid: String
    let rssi: Int
    let status: String
    
    static func == (lhs: BluetoothDevice, rhs: BluetoothDevice) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.uuid == rhs.uuid &&
        lhs.rssi == rhs.rssi &&
        lhs.status == rhs.status
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(uuid)
        hasher.combine(rssi)
        hasher.combine(status)
    }
}
