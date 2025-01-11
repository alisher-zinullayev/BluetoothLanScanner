//
//  ScanHistoryCoordinatorProtocol.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import Foundation

@MainActor
protocol ScanHistoryCoordinatorProtocol {
    func showSessionDetails(session: ScanSession)
    func showLanDeviceDetails(device: LanDeviceObject)
    func showBluetoothDeviceDetails(device: BluetoothDeviceObject)
}
