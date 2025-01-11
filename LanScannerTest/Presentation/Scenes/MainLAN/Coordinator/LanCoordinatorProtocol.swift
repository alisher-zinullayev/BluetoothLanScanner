//
//  LanCoordinatorProtocol.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import LanScanner

@MainActor
protocol LanCoordinatorProtocol {
    func showDeviceDetails(device: LanDevice)
}
