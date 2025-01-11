//
//  LanDevice.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation
import LanScanner

extension LanDevice: @retroactive Identifiable {
    public var id: String {
        return "\(name)-\(ipAddress)"
    }
}
