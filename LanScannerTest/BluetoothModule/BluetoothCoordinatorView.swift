//
//  BluetoothCoordinatorView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI

struct BluetoothCoordinatorView: View {
    private let factory: BluetoothViewFactory
    @ObservedObject private var coordinator: BluetoothCoordinator
    
    init(factory: BluetoothViewFactory, coordinator: BluetoothCoordinator) {
        self.factory = factory
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationView {
            factory.makeBluetoothView(coordinator: coordinator)
                .navigationBarTitle("Bluetooth", displayMode: .inline)
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
            factory.makeBluetoothDeviceDetailView(device: device)
        } else {
            EmptyView()
        }
    }
}

//NavigationView {
//    factory.makeBluetoothView(coordinator: coordinator)
//        .navigationBarTitle("Bluetooth", displayMode: .inline)
//        .background(
//            NavigationLink(
//                destination: BluetoothDeviceDetailView(device: extractDevice(from: coordinator.currentScreen)),
//                tag: BluetoothCoordinator.Screen.deviceDetails(extractDevice(from: coordinator.currentScreen)),
//                selection: Binding(
//                    get: {
//                        if case .deviceDetails(let device) = coordinator.currentScreen {
//                            return BluetoothCoordinator.Screen.deviceDetails(device)
//                        }
//                        return nil
//                    },
//                    set: { newValue in
//                        if case .deviceDetails(_) = newValue {
//                            coordinator.currentScreen = newValue
//                        }
//                    }
//                )
//            ) {
//                EmptyView()
//            }
//        )
//}
