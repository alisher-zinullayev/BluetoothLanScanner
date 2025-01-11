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
            ScanButtonView(viewModel: viewModel)
            deviceList
        }
        .navigationTitle("Bluetooth Сканер")
        .alert(item: $viewModel.alertItem, content: alertView(for:))
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

    var deviceList: some View {
        List(viewModel.bluetoothDevices) { device in
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
