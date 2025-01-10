//
//  SessionDetailView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

//struct SessionDetailView: View {
//    let session: ScanSession
//
//    var body: some View {
//        List {
//            if let bluetoothDevices = session.bluetoothDevices as? Set<BluetoothDeviceObject> {
//                Section(header: Text("Bluetooth Devices")) {
//                    ForEach(Array(bluetoothDevices), id: \.id) { device in
//                        Text("Name: \(device.name ?? "Unknown")")
//                    }
//                }
//            }
//
//            if let lanDevices = session.lanDevices as? Set<LanDeviceObject> {
//                Section(header: Text("LAN Devices")) {
//                    ForEach(Array(lanDevices), id: \.id) { device in
//                        Text("IP: \(device.ipAddress ?? "Unknown")")
//                    }
//                }
//            }
//        }
//        .navigationTitle("Session Details")
//    }
//}

struct SessionDetailView: View {
    let session: ScanSession

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
                NavigationLink(destination: BluetoothDeviceDetailView(device: device.toDomain())) {
                    VStack(alignment: .leading) {
                        Text("Name: \(device.name ?? "Unknown")")
                            .font(.headline)
                        Text("UUID: \(device.uuid ?? "Unknown")")
                            .font(.subheadline)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func lanDeviceList(devices: Set<LanDeviceObject>) -> some View {
        Section(header: Text("LAN Devices")) {
            ForEach(Array(devices), id: \.id) { device in
                NavigationLink(destination: LanDeviceDetailViewObject(device: device)) {
                    VStack(alignment: .leading) {
                        Text("IP: \(device.ipAddress ?? "Unknown")")
                            .font(.headline)
                        Text("Name: \(device.name ?? "Unknown")")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}
