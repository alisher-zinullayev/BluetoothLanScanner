//
//  ScanHistoryCoordinator.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import Foundation

final class ScanHistoryCoordinator: Coordinator {
    enum Screen: Routable, Identifiable, Hashable {
        case sessionDetails(ScanSession)
        case lanDeviceDetails(LanDeviceObject)
        case bluetoothDeviceDetails(BluetoothDeviceObject)

        var id: String {
            switch self {
            case .sessionDetails(let session):
                return session.id?.uuidString ?? UUID().uuidString
            case .lanDeviceDetails(let device):
                return device.id?.uuidString ?? UUID().uuidString
            case .bluetoothDeviceDetails(let device):
                return device.id?.uuidString ?? UUID().uuidString
            }
        }

        static func == (lhs: Screen, rhs: Screen) -> Bool {
            lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }

    @Published var currentScreen: Screen? = nil

    private let factory: ScanHistoryViewFactory

    init(factory: ScanHistoryViewFactory) {
        self.factory = factory
    }
}

extension ScanHistoryCoordinator: ScanHistoryCoordinatorProtocol {
    func showSessionDetails(session: ScanSession) {
        currentScreen = .sessionDetails(session)
    }

    func showLanDeviceDetails(device: LanDeviceObject) {
        currentScreen = .lanDeviceDetails(device)
    }

    func showBluetoothDeviceDetails(device: BluetoothDeviceObject) {
        currentScreen = .bluetoothDeviceDetails(device)
    }
}
