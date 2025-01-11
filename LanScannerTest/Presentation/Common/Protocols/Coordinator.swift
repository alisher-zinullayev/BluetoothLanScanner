//
//  Coordinator.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation

protocol Coordinator: ObservableObject where Screen: Routable {
    associatedtype Screen
    var currentScreen: Screen? { get set }
}
