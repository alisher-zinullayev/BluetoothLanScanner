//
//  MainCoordinatorView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI

struct MainCoordinatorView: View {
    enum Tab {
        case bluetooth
        case lan
    }
    
    @State private var selectedTab: Tab = .bluetooth
    
    private let bluetoothCoordinator: BluetoothCoordinator
    private let lanCoordinator: LanCoordinator
    
    init() {
        bluetoothCoordinator = .init()
        lanCoordinator = .init()
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BluetoothCoordinatorView(coordinator: bluetoothCoordinator)
                .tabItem {
                    Label("Bluetooth", systemImage: "dot.radiowaves.left.and.right")
                }
                .tag(Tab.bluetooth)
            
            LanCoordinatorView(coordinator: lanCoordinator)
                .tabItem {
                    Label("LAN", systemImage: "network")
                }
                .tag(Tab.lan)
        }
    }
}

#Preview {
    MainCoordinatorView()
}
