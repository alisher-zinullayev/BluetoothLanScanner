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
        case history
    }
    
    @State private var selectedTab: Tab = .bluetooth
    
    private let screenFactory: ScreenFactory
    private let bluetoothCoordinator: BluetoothCoordinator
    private let lanCoordinator: LanCoordinator
    
    init(screenFactory: ScreenFactory) {
        bluetoothCoordinator = BluetoothCoordinator(factory: screenFactory)
        lanCoordinator = LanCoordinator(factory: screenFactory)
        self.screenFactory = screenFactory
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            screenFactory.makeBluetoothCoordinatorView(coordinator: bluetoothCoordinator)
                .tabItem {
                    Label("Bluetooth", systemImage: "dot.radiowaves.left.and.right")
                }
                .tag(Tab.bluetooth)
            
            screenFactory.makeLanCoordinatorView(coordinator: lanCoordinator)
                .tabItem {
                    Label("LAN", systemImage: "network")
                }
                .tag(Tab.lan)
            
            ScanHistoryView()
                .tabItem {
                    Label("История", systemImage: "clock")
                }
                .tag(Tab.history)
        }
    }
}
//
//#Preview {
//    MainCoordinatorView()
//}
