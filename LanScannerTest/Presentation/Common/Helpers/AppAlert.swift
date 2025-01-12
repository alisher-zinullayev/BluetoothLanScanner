//
//  AppAlert.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 12.01.2025.
//

import Foundation

enum AppAlert: Identifiable {
    case error(String)
    case completion(String)
    
    var id: String {
        switch self {
        case .error(let message): return "\(message)"
        case .completion(let message): return "\(message)"
        }
    }
    
    var title: String {
        switch self {
        case .error: return "Ошибка"
        case .completion: return "Сканирование Завершено"
        }
    }
    
    var message: String {
        switch self {
        case .error(let message),
             .completion(let message):
            return message
        }
    }
}
