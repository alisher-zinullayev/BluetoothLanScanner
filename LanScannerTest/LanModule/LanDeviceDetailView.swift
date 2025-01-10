// DeviceDetailView.swift
import SwiftUI
import LanScanner

struct LanDeviceDetailView: View {
    let device: LanDevice
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "desktopcomputer")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
                Text(device.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Имя устройства:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(device.name)
                }
                
                HStack {
                    Text("MAC-адрес:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(device.mac == "02:00:00:00:00:00" ? "Недоступно" : device.mac)
                        .foregroundColor(device.mac == "02:00:00:00:00:00" ? .red : .primary)
                }
                
                HStack {
                    Text("Бренд:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(device.brand)
                }
                
                HStack {
                    Text("IP-адрес:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(device.ipAddress)
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
