//
//  LanView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import SwiftUI
import LanScanner

struct LanView: View {
    @StateObject var viewModel: LanViewModel
    
    init(viewModel: LanViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            mainContent
                .navigationTitle("LAN Scanner")
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: "Поиск устройств"
                )
                .alert(isPresented: $viewModel.showAlert, content: alertContent)
                .alert(isPresented: $viewModel.showErrorAlert, content: errorAlertContent)
            
            if viewModel.showToast {
                ToastView(message: viewModel.toastMessage)
            }
        }
    }
}

private extension LanView {
    var mainContent: some View {
        VStack(alignment: .leading) {
            headerSection
            scanDurationSection
            deviceList
        }
    }
    
    var headerSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: viewModel.reload) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(viewModel.isScanning ? .gray : .blue)
                }
                .disabled(viewModel.isScanning)
            }
            .padding(.horizontal, 20)
            
            ProgressView(value: viewModel.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .padding(.horizontal, 20)
        }
        .padding(.top, 10)
    }
    
    var scanDurationSection: some View {
        VStack(alignment: .leading) {
            Text("Время сканирования: \(Int(viewModel.scanDuration)) секунд")
                .font(.headline)
            
            Slider(value: $viewModel.scanDuration, in: 10...60, step: 5)
                .accentColor(.blue)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    var deviceList: some View {
        List(filteredDevices) { device in
            deviceRow(for: device)
                .contextMenu {
                    deviceContextMenu(for: device)
                }
        }
        .listStyle(.plain)
    }
}

private extension LanView {
    func deviceRow(for device: LanDevice) -> some View {
        Button {
            viewModel.showDeviceDetails(device: device)
        } label: {
            HStack {
                Image(systemName: "desktopcomputer")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(device.name)
                        .font(.headline)
                    
                    Text("MAC: \(device.mac == "02:00:00:00:00:00" ? "Недоступно" : device.mac)")
                        .font(.subheadline)
                        .foregroundColor(device.mac == "02:00:00:00:00:00" ? .red : .secondary)
                    
                    Text("Бренд: \(device.brand)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("IP: \(device.ipAddress)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 5)
        }
    }
    
    func deviceContextMenu(for device: LanDevice) -> some View {
        Group {
            Button {
                UIPasteboard.general.string = device.name
                viewModel.showToast(message: "Имя устройства скопировано")
            } label: {
                Label("Скопировать имя", systemImage: "doc.on.doc")
            }
            
            Button {
                UIPasteboard.general.string = device.mac
                viewModel.showToast(message: "MAC-адрес скопирован")
            } label: {
                Label("Скопировать MAC", systemImage: "doc.on.doc")
            }
            
            Button {
                UIPasteboard.general.string = device.ipAddress
                viewModel.showToast(message: "IP-адрес скопирован")
            } label: {
                Label("Скопировать IP", systemImage: "doc.on.doc")
            }
        }
    }
}

private extension LanView {
    func alertContent() -> Alert {
        Alert(
            title: Text(
                viewModel.alertMessage.contains("Нет доступа") ? "Ошибка" : "Сканирование завершено"
            ),
            message: Text(viewModel.alertMessage),
            dismissButton: .default(Text("OK"))
        )
    }
    
    func errorAlertContent() -> Alert {
        Alert(
            title: Text("Ошибка"),
            message: Text(viewModel.errorMessage),
            dismissButton: .default(Text("OK"))
        )
    }
}

private extension LanView {
    var filteredDevices: [LanDevice] {
        if viewModel.searchText.isEmpty {
            return viewModel.connectedDevices
        } else {
            return viewModel.connectedDevices.filter {
                $0.name.lowercased().contains(viewModel.searchText.lowercased())
            }
        }
    }
}
