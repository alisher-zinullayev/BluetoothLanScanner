//
//  MainCoordinatorView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI

//struct MainCoordinatorView: View {
//    enum Tab {
//        case bluetooth
//        case lan
//        case history
//    }
//    
//    @State private var selectedTab: Tab = .bluetooth
//    
//    private let screenFactory: ScreenFactory
//    private let bluetoothCoordinator: BluetoothCoordinator
//    private let lanCoordinator: LanCoordinator
//    private let scanHistoryCoordinator: ScanHistoryCoordinator
//    
//    init(screenFactory: ScreenFactory) {
//        bluetoothCoordinator = BluetoothCoordinator(factory: screenFactory)
//        lanCoordinator = LanCoordinator(factory: screenFactory)
//        scanHistoryCoordinator = ScanHistoryCoordinator(factory: screenFactory)
//        self.screenFactory = screenFactory
//    }
//    
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            screenFactory.makeBluetoothCoordinatorView(coordinator: bluetoothCoordinator)
//                .tabItem {
//                    Label("Bluetooth", systemImage: "dot.radiowaves.left.and.right")
//                }
//                .tag(Tab.bluetooth)
//            
//            screenFactory.makeLanCoordinatorView(coordinator: lanCoordinator)
//                .tabItem {
//                    Label("LAN", systemImage: "network")
//                }
//                .tag(Tab.lan)
//            
//            screenFactory.makeScanHistoryView(coordinator: scanHistoryCoordinator)
//                .tabItem {
//                    Label("История", systemImage: "clock")
//                }
//                .tag(Tab.history)
//        }
//    }
//}
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
    private let scanHistoryCoordinator: ScanHistoryCoordinator
    
    init(screenFactory: ScreenFactory) {
        self.bluetoothCoordinator = BluetoothCoordinator(factory: screenFactory)
        self.lanCoordinator = LanCoordinator(factory: screenFactory)
        self.scanHistoryCoordinator = ScanHistoryCoordinator(factory: screenFactory)
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
            
            ScanHistoryCoordinatorView(factory: screenFactory, coordinator: scanHistoryCoordinator)
                .tabItem {
                    Label("История", systemImage: "clock")
                }
                .tag(Tab.history)
        }
    }
}
