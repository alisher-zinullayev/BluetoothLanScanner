//
//  BluetoothCoordinatorView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI

struct BluetoothCoordinatorView: View {
    @ObservedObject private var coordinator: BluetoothCoordinator
    
    init(coordinator: BluetoothCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationView {
            BluetoothView(viewModel: BluetoothViewModel(coordinator: coordinator))
                .navigationBarTitle("Bluetooth", displayMode: .inline)
                .background(
                    NavigationLink(
                        destination: BluetoothDeviceDetailView(device: extractDevice(from: coordinator.currentScreen)),
                        tag: BluetoothCoordinator.Screen.deviceDetails(extractDevice(from: coordinator.currentScreen)),
                        selection: Binding(
                            get: {
                                if case .deviceDetails(let device) = coordinator.currentScreen {
                                    return BluetoothCoordinator.Screen.deviceDetails(device)
                                }
                                return nil
                            },
                            set: { newValue in
                                if case .deviceDetails(_) = newValue {
                                    coordinator.currentScreen = newValue
                                }
                            }
                        )
                    ) {
                        EmptyView()
                    }
                )
        }
    }
    
    private func extractDevice(from screen: BluetoothCoordinator.Screen?) -> BluetoothDevice {
        if case .deviceDetails(let device) = screen {
            return device
        }
        return BluetoothDevice(id: UUID(), name: "Unknown", uuid: "Unknown", rssi: 0, status: "Unknown")
    }
}
