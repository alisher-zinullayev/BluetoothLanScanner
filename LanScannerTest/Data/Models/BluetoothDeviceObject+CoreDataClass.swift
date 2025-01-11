//
//  BluetoothDeviceObject+CoreDataClass.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//
//

import Foundation
import CoreData

@objc(BluetoothDeviceObject)
public class BluetoothDeviceObject: NSManagedObject {
    
}

extension BluetoothDeviceObject {
    func toDomain() -> BluetoothDevice {
        return BluetoothDevice(
            id: id ?? UUID(),
            name: name ?? "Unknown",
            uuid: uuid ?? "Unknown",
            rssi: Int(rssi),
            status: status ?? "Unknown"
        )
    }
}
