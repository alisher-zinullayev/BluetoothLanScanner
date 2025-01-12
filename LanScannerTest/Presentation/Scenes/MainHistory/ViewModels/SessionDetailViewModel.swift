//
//  SessionDetailViewModel.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 12.01.2025.
//

import SwiftUI

final class SessionDetailViewModel: ObservableObject {
    private let coordinator: ScanHistoryCoordinatorProtocol
    let session: ScanSession

    init(session: ScanSession, coordinator: ScanHistoryCoordinatorProtocol) {
        self.session = session
        self.coordinator = coordinator
    }

    var bluetoothDevices: [BluetoothDeviceObject] {
        if let set = session.bluetoothDevices as? Set<BluetoothDeviceObject> {
            return Array(set)
        }
        return []
    }

    var lanDevices: [LanDeviceObject] {
        if let set = session.lanDevices as? Set<LanDeviceObject> {
            return Array(set)
        }
        return []
    }

    @MainActor func showBluetoothDeviceDetails(_ device: BluetoothDeviceObject) {
        coordinator.showBluetoothDeviceDetails(device: device)
    }

    @MainActor func showLanDeviceDetails(_ device: LanDeviceObject) {
        coordinator.showLanDeviceDetails(device: device)
    }
}
