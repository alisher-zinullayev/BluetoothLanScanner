//
//  ScreenFactory.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import LanScanner

final class ScreenFactory: AppCoordinatorFactory {
    private let appFactory: AppFactory

    init(appFactory: AppFactory) {
        self.appFactory = appFactory
    }
}

// MARK: - BluetoothViewFactory

extension ScreenFactory: BluetoothViewFactory {
    func makeBluetoothView(coordinator: BluetoothCoordinatorProtocol) -> BluetoothView {
        let bluetoothService = appFactory.makeBluetoothService()
        let viewModel = BluetoothViewModel(coordinator: coordinator, bluetoothService: bluetoothService)
        return BluetoothView(viewModel: viewModel)
    }

    func makeBluetoothDeviceDetailView(device: BluetoothDevice) -> BluetoothDeviceDetailView {
        return BluetoothDeviceDetailView(device: device)
    }
}

// MARK: - LanViewFactory

extension ScreenFactory: LanViewFactory {
    func makeLanView(coordinator: LanCoordinatorProtocol) -> LanView {
        let viewModel = LanViewModel(coordinator: coordinator)
        return LanView(viewModel: viewModel)
    }

    func makeLanDeviceDetailView(device: LanDevice) -> LanDeviceDetailView {
        return LanDeviceDetailView(device: device)
    }
}

// MARK: - MainCoordinatorViewFactory

extension ScreenFactory: MainCoordinatorViewFactory {
    func makeMainCoordinatorView() -> MainCoordinatorView {
        return MainCoordinatorView(screenFactory: self)
    }
}

// MARK: - BluetoothCoordinatorFactory
extension ScreenFactory: BluetoothCoordinatorFactory {
    func makeBluetoothCoordinatorView(coordinator: BluetoothCoordinatorProtocol) -> BluetoothCoordinatorView {
        BluetoothCoordinatorView(factory: self, coordinator: coordinator as! BluetoothCoordinator)
    }
}

// MARK: - LanCoordinatorFactory
extension ScreenFactory: LanCoordinatorFactory {
    func makeLanCoordinatorView(coordinator: LanCoordinatorProtocol) -> LanCoordinatorView {
        LanCoordinatorView(factory: self, coordinator: coordinator as! LanCoordinator)
    }
}
