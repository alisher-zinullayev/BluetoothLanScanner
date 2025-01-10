//
//  BluetoothView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI

struct BluetoothView: View {
    @StateObject var viewModel: BluetoothViewModel
    
    var body: some View {
        VStack {
            if viewModel.isScanning {
                // Индикатор прогресса
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
                Button(action: {
                    viewModel.showDeviceDetails(device: device)
                }) {
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
        // Алерты для ошибок и завершения сканирования
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
