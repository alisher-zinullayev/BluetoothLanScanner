//
//  SessionDetailView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

struct SessionDetailView: View {
    let session: ScanSession
    private let coordinator: ScanHistoryCoordinator

    init(session: ScanSession, coordinator: ScanHistoryCoordinator) {
        self.session = session
        self.coordinator = coordinator
    }

    var body: some View {
        List {
            if let bluetoothDevices = session.bluetoothDevices as? Set<BluetoothDeviceObject> {
                bluetoothDeviceList(devices: bluetoothDevices)
            }

            if let lanDevices = session.lanDevices as? Set<LanDeviceObject> {
                lanDeviceList(devices: lanDevices)
            }
        }
        .navigationTitle("Session Details")
    }

    @ViewBuilder
    private func bluetoothDeviceList(devices: Set<BluetoothDeviceObject>) -> some View {
        Section(header: Text("Bluetooth Devices")) {
            ForEach(Array(devices), id: \.id) { device in
                Button(action: {
                    coordinator.showBluetoothDeviceDetails(device: device)
                }) {
                    VStack(alignment: .leading) {
                        Text("Name: \(device.name ?? "Unknown")")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("UUID: \(device.uuid ?? "Unknown")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func lanDeviceList(devices: Set<LanDeviceObject>) -> some View {
        Section(header: Text("LAN Devices")) {
            ForEach(Array(devices), id: \.id) { device in
                Button(action: {
                    coordinator.showLanDeviceDetails(device: device)
                }) {
                    VStack(alignment: .leading) {
                        Text("IP: \(device.ipAddress ?? "Unknown")")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("Name: \(device.name ?? "Unknown")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
