//
//  LocalizedKey.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

enum LocalizedKey {

    enum General {
        static let bluetooth = LocalizedStringKey("Bluetooth")
        static let lan = LocalizedStringKey("LAN")
        static let ip = LocalizedStringKey("IP: %@")
        static let mac = LocalizedStringKey("MAC: %@")
        static let name = LocalizedStringKey("Name: %@")
        static let uuid = LocalizedStringKey("UUID: %@")
        static let brand = LocalizedStringKey("Brand: %@")
        static let ok = LocalizedStringKey("OK")
        static let error = LocalizedStringKey("Error")
    }

    enum Bluetooth {
        static let devices = LocalizedStringKey("Bluetooth Devices")
        static let scanner = LocalizedStringKey("Bluetooth Scanner")
    }

    enum LAN {
        static let devices = LocalizedStringKey("LAN Devices")
        static let scanner = LocalizedStringKey("LAN Scanner")
    }

    enum ScanHistory {
        static let title = LocalizedStringKey("Scan History")
        static let sessionDetails = LocalizedStringKey("Session Details")
    }

    enum DeviceDetails {
        static let deviceDetails = LocalizedStringKey("Device details")
    }

    enum Scanning {
        static let scanningTime = LocalizedStringKey("Scanning time: %lld seconds")
        static let startScan = LocalizedStringKey("Start scan")
        static let restartScan = LocalizedStringKey("Restart scan")
        static let scanningComplete = LocalizedStringKey("Scan complete")
        static let scanningInProgress = LocalizedStringKey("Scanning...")
        static let deviceSearch = LocalizedStringKey("Device Search")
    }

    enum Actions {
        static let copyIP = LocalizedStringKey("Copy IP")
        static let copyMAC = LocalizedStringKey("Copy MAC")
        static let copyName = LocalizedStringKey("Copy name")
    }

    enum Status {
        static let status = LocalizedStringKey("Status: %@")
    }
}
