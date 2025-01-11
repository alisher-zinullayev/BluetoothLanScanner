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
            content
                .navigationTitle("LAN Scanner")
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: "Поиск устройств"
                )
                .alert(isPresented: $viewModel.showAlert, content: alertContent)
                .alert(isPresented: $viewModel.showErrorAlert, content: errorAlertContent)
            
            if viewModel.showToast {
                toast
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            headerSection
            scanDurationSection
            deviceList
        }
    }
    
    private var headerSection: some View {
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
                .accessibilityLabel("Перезапустить сканирование")
            }
            .padding([.leading, .trailing], 20)
            
            ProgressView(value: viewModel.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .padding([.leading, .trailing], 20)
        }
        .padding(.top, 10)
    }
    
    // MARK: - Scan Duration Section
    private var scanDurationSection: some View {
        VStack(alignment: .leading) {
            Text("Время сканирования: \(Int(viewModel.scanDuration)) секунд")
                .font(.headline)
            Slider(value: $viewModel.scanDuration, in: 10...60, step: 5)
                .accentColor(.blue)
        }
        .padding([.leading, .trailing], 20)
        .padding(.top, 10)
    }
    
    private var deviceList: some View {
        List(filteredDevices) { device in
            deviceRow(for: device)
                .contextMenu { deviceContextMenu(for: device) }
        }
        .listStyle(PlainListStyle())
    }
    
    private func deviceRow(for device: LanDevice) -> some View {
        Button(action: { viewModel.showDeviceDetails(device: device) }) {
            HStack {
                Image(systemName: "desktopcomputer")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(device.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
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
    
    private func deviceContextMenu(for device: LanDevice) -> some View {
        Group {
            Button(action: {
                UIPasteboard.general.string = device.name
                viewModel.showToast(message: "Имя устройства скопировано")
            }) {
                Text("Скопировать имя")
                Image(systemName: "doc.on.doc")
            }
            
            Button(action: {
                UIPasteboard.general.string = device.mac
                viewModel.showToast(message: "MAC-адрес скопирован")
            }) {
                Text("Скопировать MAC")
                Image(systemName: "doc.on.doc")
            }
            
            Button(action: {
                UIPasteboard.general.string = device.ipAddress
                viewModel.showToast(message: "IP-адрес скопирован")
            }) {
                Text("Скопировать IP")
                Image(systemName: "doc.on.doc")
            }
        }
    }
    
    // MARK: - Toast
    private var toast: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(viewModel.toastMessage)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom, 50)
                Spacer()
            }
            .transition(.slide)
            .animation(.easeInOut, value: viewModel.showToast)
        }
    }
    
    // MARK: - Alerts
    private func alertContent() -> Alert {
        Alert(
            title: Text(viewModel.alertMessage.contains("Нет доступа") ? "Ошибка" : "Сканирование завершено"),
            message: Text(viewModel.alertMessage),
            dismissButton: .default(Text("OK"))
        )
    }
    
    private func errorAlertContent() -> Alert {
        Alert(
            title: Text("Ошибка"),
            message: Text(viewModel.errorMessage),
            dismissButton: .default(Text("OK"))
        )
    }
    
    // MARK: - Filtered Devices
    private var filteredDevices: [LanDevice] {
        if viewModel.searchText.isEmpty {
            return viewModel.connectedDevices
        } else {
            return viewModel.connectedDevices.filter { $0.name.lowercased().contains(viewModel.searchText.lowercased()) }
        }
    }
}
