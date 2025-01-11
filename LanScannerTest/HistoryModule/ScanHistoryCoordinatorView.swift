//
//  ScanHistoryCoordinatorView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

struct ScanHistoryCoordinatorView: View {
    private let factory: ScanHistoryViewFactory
    @ObservedObject private var coordinator: ScanHistoryCoordinator

    init(factory: ScanHistoryViewFactory, coordinator: ScanHistoryCoordinator) {
        self.factory = factory
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationView {
            factory.makeScanHistoryView(coordinator: coordinator)
                .background(navigationLink)
        }
    }

    private var navigationLink: some View {
        NavigationLink(
            destination: destinationView,
            isActive: isActiveBinding
        ) {
            EmptyView()
        }
    }

    private var isActiveBinding: Binding<Bool> {
        Binding(
            get: { coordinator.currentScreen != nil },
            set: { isActive in
                if !isActive {
                    coordinator.currentScreen = nil
                }
            }
        )
    }

    @ViewBuilder
    private var destinationView: some View {
        if let screen = coordinator.currentScreen {
            switch screen {
            case .sessionDetails(let session):
                factory.makeSessionDetailView(session: session, coordinator: coordinator)
            case .lanDeviceDetails(let device):
                factory.makeLanDeviceDetailView(device: device)
            case .bluetoothDeviceDetails(let device):
                factory.makeBluetoothDeviceDetailObjectView(device: device.toDomain())
            }
        } else {
            EmptyView()
        }
    }
}
