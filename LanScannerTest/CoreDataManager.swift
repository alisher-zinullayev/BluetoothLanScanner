//
//  CoreDataManager.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AllDevicesModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // Сохранение Bluetooth устройства
    func saveBluetoothDevice(
        id: UUID,
        name: String?,
        uuid: String,
        rssi: Int32,
        status: String?,
        session: ScanSession
    ) {
        let device = BluetoothDeviceObject(context: context)
        device.id = id
        device.name = name
        device.uuid = uuid
        device.rssi = rssi
        device.status = status
        device.session = session

        saveContext()
    }

    // Сохранение LAN устройства
    func saveLanDevice(
        id: UUID,
        ipAddress: String,
        name: String?,
        brand: String?,
        mac: String,
        session: ScanSession
    ) {
        let device = LanDeviceObject(context: context)
        device.id = id
        device.ipAddress = ipAddress
        device.name = name
        device.brand = brand
        device.mac = mac
        device.session = session

        saveContext()
    }

    // Создание сессии
    func createScanSession() -> ScanSession {
        let session = ScanSession(context: context)
        session.id = UUID()
        session.timestamp = Date()

        saveContext()
        return session
    }
    
    func fetchScanSessions() -> [ScanSession] {
        let request: NSFetchRequest<ScanSession> = ScanSession.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching ScanSessions: \(error)")
            return []
        }
    }
}
