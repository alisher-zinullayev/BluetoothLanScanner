//
//  BluetoothDeviceObject+CoreDataProperties.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//
//

import Foundation
import CoreData


extension BluetoothDeviceObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BluetoothDeviceObject> {
        return NSFetchRequest<BluetoothDeviceObject>(entityName: "BluetoothDeviceObject")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var rssi: Int32
    @NSManaged public var status: String?
    @NSManaged public var uuid: String?
    @NSManaged public var session: ScanSession?

}

extension BluetoothDeviceObject : Identifiable {

}
