//
//  ScanSession+CoreDataProperties.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//
//

import Foundation
import CoreData


extension ScanSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScanSession> {
        return NSFetchRequest<ScanSession>(entityName: "ScanSession")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var timestamp: Date?
    @NSManaged public var bluetoothDevices: NSSet?
    @NSManaged public var lanDevices: NSSet?

}

// MARK: Generated accessors for bluetoothDevices
extension ScanSession {

    @objc(addBluetoothDevicesObject:)
    @NSManaged public func addToBluetoothDevices(_ value: BluetoothDeviceObject)

    @objc(removeBluetoothDevicesObject:)
    @NSManaged public func removeFromBluetoothDevices(_ value: BluetoothDeviceObject)

    @objc(addBluetoothDevices:)
    @NSManaged public func addToBluetoothDevices(_ values: NSSet)

    @objc(removeBluetoothDevices:)
    @NSManaged public func removeFromBluetoothDevices(_ values: NSSet)

}

// MARK: Generated accessors for lanDevices
extension ScanSession {

    @objc(addLanDevicesObject:)
    @NSManaged public func addToLanDevices(_ value: LanDeviceObject)

    @objc(removeLanDevicesObject:)
    @NSManaged public func removeFromLanDevices(_ value: LanDeviceObject)

    @objc(addLanDevices:)
    @NSManaged public func addToLanDevices(_ values: NSSet)

    @objc(removeLanDevices:)
    @NSManaged public func removeFromLanDevices(_ values: NSSet)

}

extension ScanSession : Identifiable {

}
