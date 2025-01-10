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
                Section(header: Text("Bluetooth Devices")) {
                    bluetoothDeviceList(devices: bluetoothDevices)
                }
            }

            if let lanDevices = session.lanDevices as? Set<LanDeviceObject> {
                Section(header: Text("LAN Devices")) {
                    lanDeviceList(devices: lanDevices)
                }
            }
        }
        .navigationTitle("Session Details")
    }

    private func bluetoothDeviceList(devices: Set<BluetoothDeviceObject>) -> some View {
        let deviceArray = Array(devices)

        return ForEach(deviceArray, id: \.id) { device in
            NavigationLink(
                destination: BluetoothDeviceDetailView(device: device)
            ) {
                VStack(alignment: .leading) {
                    Text("Name: \(device.name ?? "Unknown")")
                    Text("UUID: \(device.uuid ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }

    private func lanDeviceList(devices: Set<LanDeviceObject>) -> some View {
        let deviceArray = Array(devices)

        return ForEach(deviceArray, id: \.id) { device in
            NavigationLink(
                destination: LanDeviceDetailView(device: device)
            ) {
                VStack(alignment: .leading) {
                    Text("IP: \(device.ipAddress ?? "Unknown")")
                    Text("MAC: \(device.mac ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
