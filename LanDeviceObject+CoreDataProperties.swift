//
//  LanDeviceObject+CoreDataProperties.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//
//

import Foundation
import CoreData


extension LanDeviceObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LanDeviceObject> {
        return NSFetchRequest<LanDeviceObject>(entityName: "LanDeviceObject")
    }

    @NSManaged public var brand: String?
    @NSManaged public var id: UUID?
    @NSManaged public var ipAddress: String?
    @NSManaged public var mac: String?
    @NSManaged public var name: String?
    @NSManaged public var session: ScanSession?

}

extension LanDeviceObject : Identifiable {

}
