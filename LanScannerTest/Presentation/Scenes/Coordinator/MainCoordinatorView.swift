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
                    Label("Bluetooth", systemImage: Constants.bluetoothImage)
                }
                .tag(Tab.bluetooth)
            
            screenFactory.makeLanCoordinatorView(coordinator: lanCoordinator)
                .tabItem {
                    Label("LAN", systemImage: Constants.networkImage)
                }
                .tag(Tab.lan)
            
            ScanHistoryCoordinatorView(factory: screenFactory, coordinator: scanHistoryCoordinator)
                .tabItem {
                    Label("История", systemImage: Constants.historyImage)
                }
                .tag(Tab.history)
        }
        .tintColor(.blue)
        .onAppear {
            setupTabBar()
        }
    }
    
    private enum Constants {
        static let bluetoothImage = "dot.radiowaves.left.and.right"
        static let networkImage = "network"
        static let historyImage = "clock"
    }
    
    @MainActor private func setupTabBar() {
        UITabBar.appearance().tintColor = UIColor(.white)
        UITabBar.appearance().isTranslucent = true

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
    }
}
