//
//  BluetoothDeviceRow.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

struct BluetoothDeviceRow: View {
    let device: BluetoothDevice
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading) {
                Text(device.name)
                    .font(.headline)
                HStack {
                    Text("UUID: \(device.uuid)")
                    Spacer()
                    Text("RSSI: \(device.rssi)")
                }
                .font(.subheadline)
                Text("Статус: \(device.status)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
