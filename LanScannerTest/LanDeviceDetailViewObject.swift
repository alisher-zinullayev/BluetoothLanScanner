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
            HStack {
                Image(systemName: "desktopcomputer")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
                Text(device.name ?? "Unknown")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.bottom, 20)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Имя устройства:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(device.name ?? "Unknown")
                }

                HStack {
                    Text("MAC-адрес:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(device.mac ?? "Unknown")
                        .foregroundColor((device.mac ?? "") == "02:00:00:00:00:00" ? .red : .primary)
                }

                HStack {
                    Text("Бренд:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(device.brand ?? "Unknown")
                }

                HStack {
                    Text("IP-адрес:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(device.ipAddress ?? "Unknown")
                }
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)

            Spacer()
        }
        .padding()
        .navigationTitle("Детали устройства")
    }
}
