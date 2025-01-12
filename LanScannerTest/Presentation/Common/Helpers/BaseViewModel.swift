//
//  BaseViewModel.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 12.01.2025.
//

import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    @Published var appAlert: AppAlert?
    
    func handleError(_ message: String) {
        self.appAlert = .error(message)
    }
    
    func handleCompletion(_ message: String) {
        self.appAlert = .completion(message)
    }
}

