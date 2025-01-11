//
//  LanDeviceDetailViewObject.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

struct LanDeviceDetailViewObject: View {
    let device: LanDeviceObject

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            headerView
                .padding(.bottom, 20)

            detailsView
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)

            Spacer()
        }
        .padding()
        .navigationTitle("Детали устройства")
    }

    private var headerView: some View {
        HStack {
            Image(systemName: "desktopcomputer")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.green)
            Text(device.name ?? "Unknown")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }

    private var detailsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            detailRow(title: "Имя устройства:", value: device.name ?? "Unknown")
            detailRow(title: "MAC-адрес:", value: device.mac ?? "Unknown",
                      valueColor: (device.mac ?? "") == "02:00:00:00:00:00" ? .red : .primary)
            detailRow(title: "Бренд:", value: device.brand ?? "Unknown")
            detailRow(title: "IP-адрес:", value: device.ipAddress ?? "Unknown")
        }
    }

    private func detailRow(title: String, value: String, valueColor: Color = .primary) -> some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(valueColor)
        }
    }
}
