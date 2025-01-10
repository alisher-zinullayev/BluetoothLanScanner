//
//  LanCoordinator.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI
import LanScanner

final class LanCoordinator: Coordinator {
    enum Screen: Routable, Identifiable, Hashable {
        case deviceDetails(LanDevice)
        
        var id: String {
            switch self {
            case .deviceDetails(let device):
                return device.id
            }
        }

        static func == (lhs: Screen, rhs: Screen) -> Bool {
            switch (lhs, rhs) {
            case (.deviceDetails(let lhsDevice), .deviceDetails(let rhsDevice)):
                return lhsDevice.id == rhsDevice.id
            }
        }

        func hash(into hasher: inout Hasher) {
            switch self {
            case .deviceDetails(let device):
                hasher.combine(device.id)
            }
        }
    }

    @Published var currentScreen: Screen? = nil
}


extension LanCoordinator: LanCoordinatorProtocol {
    func showDeviceDetails(device: LanDevice) {
        currentScreen = .deviceDetails(device)
    }
}
