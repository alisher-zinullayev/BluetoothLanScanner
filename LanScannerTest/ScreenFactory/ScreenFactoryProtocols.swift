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
