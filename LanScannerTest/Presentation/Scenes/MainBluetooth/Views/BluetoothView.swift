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
            scanningIndicator
            scanButton
            deviceList
        }
        .navigationTitle("Bluetooth Сканер")
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Поиск устройств"
        )
        .alert(item: $viewModel.appAlert) { appAlert in
            Alert(
                title: Text(appAlert.title),
                message: Text(appAlert.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

private extension BluetoothView {
    var scanningIndicator: some View {
        Group {
            if viewModel.isScanning {
                ProgressView("Сканирование...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
        }
    }
    
    var scanButton: some View {
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
    }

    var deviceList: some View {
        List(viewModel.filteredDevices) { device in
            BluetoothDeviceRow(device: device) {
                viewModel.showDeviceDetails(device: device)
            }
        }
    }

    func alertView(for alert: BluetoothScanAlert) -> Alert {
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
