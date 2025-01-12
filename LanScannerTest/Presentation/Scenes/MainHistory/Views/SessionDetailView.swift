//
//  SessionDetailView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

struct SessionDetailView: View {
    @StateObject var viewModel: SessionDetailViewModel

    var body: some View {
        List {
            if !viewModel.bluetoothDevices.isEmpty {
                Section("Bluetooth Devices") {
                    ForEach(viewModel.bluetoothDevices, id: \.id) { device in
                        Button {
                            viewModel.showBluetoothDeviceDetails(device)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Name: \(device.name ?? "Unknown")")
                                    .font(.headline)
                                Text("UUID: \(device.uuid ?? "Unknown")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }

            if !viewModel.lanDevices.isEmpty {
                Section("LAN Devices") {
                    ForEach(viewModel.lanDevices, id: \.id) { device in
                        Button {
                            viewModel.showLanDeviceDetails(device)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("IP: \(device.ipAddress ?? "Unknown")")
                                    .font(.headline)
                                Text("Name: \(device.name ?? "Unknown")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Session Details")
    }
}
