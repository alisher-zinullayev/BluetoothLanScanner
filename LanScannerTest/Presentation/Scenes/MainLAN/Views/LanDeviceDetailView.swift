//
//  DeviceDetailView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI
import LanScanner

struct LanDeviceDetailView: View {
    let device: LanDevice
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            headerSection
                .padding(.bottom, 20)
            
            detailsSection
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Детали устройства")
    }
    
    private var headerSection: some View {
        HStack {
            Image(systemName: "desktopcomputer")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.green)
            Text(device.name)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
    
    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            detailRow(label: "Имя устройства:", value: device.name)
            detailRow(label: "MAC-адрес:", value: device.mac == "02:00:00:00:00:00" ? "Недоступно" : device.mac)
            detailRow(label: "Бренд:", value: device.brand)
            detailRow(label: "IP-адрес:", value: device.ipAddress)
        }
    }
    
    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(value == "Недоступно" ? .red : .primary)
        }
    }
}
