//
//  ScanAlert.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation

enum BluetoothScanAlert: Identifiable {
    case error(String)
    case completion(String)
    
    var id: String {
        switch self {
        case .error(let message):
            return "\(message)"
        case .completion(let message):
            return "\(message)"
        }
    }
}
