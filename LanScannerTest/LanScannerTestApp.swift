//
//  LanScannerTestApp.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 09.01.2025.
//

import SwiftUI

@main
struct LanScannerTestApp: App {
    var body: some Scene {
        WindowGroup {
            let appFactory = AppFactory()
            let screenFactory = ScreenFactory(appFactory: appFactory)
            screenFactory.makeMainCoordinatorView()
        }
    }
}
