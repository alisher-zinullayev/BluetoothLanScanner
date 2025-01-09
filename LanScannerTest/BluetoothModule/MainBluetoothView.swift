//
//  MainBluetoothView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI

struct MainBluetoothView: View {
    @StateObject var viewModel = BluetoothViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isScanning {
                    // Progress Indicator
                    ProgressView("Сканирование...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                Button(action: {
                    viewModel.startScan()
                }) {
                    Text(viewModel.isScanning ? "Сканирование..." : "Начать сканирование")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.isScanning ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 20)
                }
                .disabled(viewModel.isScanning)
                
                List(viewModel.bluetoothDevices) { device in
                    NavigationLink(destination: BluetoothDeviceDetailView(device: device)) {
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
            .navigationTitle("Bluetooth Сканер")
            // Алерт для ошибок и завершения сканирования
            .alert(item: $viewModel.alertItem) { alert in
                switch alert {
                case .error(let message):
                    return Alert(
                        title: Text("Ошибка"),
                        message: Text(message),
                        dismissButton: .default(Text("OK"))
                    )
                case .completion(let message):
                    return Alert(
                        title: Text("Сканирование Завершено"),
                        message: Text(message),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}

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
