//
//  LanCoordinatorView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI
import LanScanner

//struct LanCoordinatorView: View {
//    @ObservedObject private var coordinator: LanCoordinator
//    
//    init(coordinator: LanCoordinator) {
//        self.coordinator = coordinator
//    }
//    
//    var body: some View {
//        NavigationView {
//            LanView(viewModel: LanViewModel(coordinator: coordinator))
//                .navigationBarTitle("LAN", displayMode: .inline)
//                .background(
//                    NavigationLink(
//                        destination: {
//                            if let screen = coordinator.currentScreen,
//                               case .deviceDetails(let device) = screen {
//                                LanDeviceDetailView(device: device)
//                            }
//                        },
//                        isActive: Binding(
//                            get: { coordinator.currentScreen != nil },
//                            set: { isActive in
//                                if !isActive { coordinator.currentScreen = nil }
//                            }
//                        )
//                    ) {
//                        EmptyView()
//                    }
//                )
//        }
//    }
//    
//    private func extractDevice(from screen: LanCoordinator.Screen?) -> LanDevice? {
//        if case .deviceDetails(let device) = screen {
//            return device
//        }
//        return nil
//    }
//}
struct LanCoordinatorView: View {
    @ObservedObject private var coordinator: LanCoordinator
    
    init(coordinator: LanCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationView {
            LanView(viewModel: LanViewModel(coordinator: coordinator))
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
            LanDeviceDetailView(device: device)
        } else {
            EmptyView() // Fallback view to ensure `NavigationLink` always has a destination
        }
    }
}
