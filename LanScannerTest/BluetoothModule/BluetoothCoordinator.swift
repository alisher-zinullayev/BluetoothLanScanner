//
//  BluetoothCoordinator.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI

final class BluetoothCoordinator: Coordinator {
    enum Screen: Routable, Identifiable, Hashable {
        case deviceDetails(BluetoothDevice)

        var id: String {
            switch self {
            case .deviceDetails(let device):
                return device.id.uuidString
            }
        }

        static func == (lhs: Screen, rhs: Screen) -> Bool {
            switch (lhs, rhs) {
            case (.deviceDetails(let lhsDevice), .deviceDetails(let rhsDevice)):
                return lhsDevice == rhsDevice
            }
        }

        func hash(into hasher: inout Hasher) {
            switch self {
            case .deviceDetails(let device):
                hasher.combine(device)
            }
        }
    }

    @Published var currentScreen: Screen? = nil
}

extension BluetoothCoordinator: BluetoothCoordinatorProtocol {
    func showDeviceDetails(device: BluetoothDevice) {
        currentScreen = .deviceDetails(device)
    }
}

