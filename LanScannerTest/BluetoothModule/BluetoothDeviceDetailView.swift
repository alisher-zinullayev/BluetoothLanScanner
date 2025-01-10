//
//  BluetoothDeviceViewM.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI

struct BluetoothDeviceDetailView: View {
    let device: BluetoothDevice
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(device.name)
                .font(.largeTitle)
                .bold()
            
            Text("UUID: \(device.uuid)")
            Text("RSSI: \(device.rssi)")
            Text("Статус: \(device.status)")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Детали Устройства")
    }
}
