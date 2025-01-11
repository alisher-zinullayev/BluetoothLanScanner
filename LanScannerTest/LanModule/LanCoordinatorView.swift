//
//  LanCoordinatorView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI
import LanScanner

struct LanCoordinatorView: View {
    private let factory: LanViewFactory
    @ObservedObject private var coordinator: LanCoordinator
    
    init(factory: LanViewFactory, coordinator: LanCoordinator) {
        self.factory = factory
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationView {
            factory.makeLanView(coordinator: coordinator)
                .navigationBarTitle("LAN", displayMode: .inline)
                .background(
                    NavigationLink(
                        destination: destinationView,
                        isActive: Binding(
                            get: { coordinator.currentScreen != nil },
                            set: { isActive in
                                if !isActive { coordinator.currentScreen = nil }
                            }
                        )
                    ) {
                        EmptyView()
                    }
                )
        }
    }
    
    @ViewBuilder
    private var destinationView: some View {
        if let screen = coordinator.currentScreen,
           case .deviceDetails(let device) = screen {
            factory.makeLanDeviceDetailView(device: device)
        } else {
            EmptyView()
        }
    }
}
