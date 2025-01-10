//
//  ScreenFactoryProtocols.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI
import LanScanner

@MainActor
protocol BluetoothViewFactory {
    func makeBluetoothView(coordinator: BluetoothCoordinatorProtocol) -> BluetoothView
    func makeBluetoothDeviceDetailView(device: BluetoothDevice) -> BluetoothDeviceDetailView
}

@MainActor
protocol LanViewFactory {
    func makeLanView(coordinator: LanCoordinatorProtocol) -> LanView
    func makeLanDeviceDetailView(device: LanDevice) -> LanDeviceDetailView
}

@MainActor
protocol MainCoordinatorViewFactory {
    func makeMainCoordinatorView() -> MainCoordinatorView
}

@MainActor
protocol ScanHistoryViewFactory {
    func makeScanHistoryView(coordinator: ScanHistoryCoordinator) -> ScanHistoryView
    func makeSessionDetailView(session: ScanSession, coordinator: ScanHistoryCoordinator) -> SessionDetailView
    func makeLanDeviceDetailView(device: LanDeviceObject) -> LanDeviceDetailViewObject
    func makeBluetoothDeviceDetailObjectView(device: BluetoothDevice) -> BluetoothDeviceDetailView
}
