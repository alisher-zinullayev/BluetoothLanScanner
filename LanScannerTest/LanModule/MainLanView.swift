//
//  ContentView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 09.01.2025.
//

import SwiftUI
import LanScanner

//struct MainLanView: View {
//    
//    @StateObject var viewModel: LanViewModel
//    
//    init(coordinator: LanCoordinator) {
//        _viewModel = StateObject(wrappedValue: LanViewModel(coordinator: coordinator))
//    }
//    
//    // Фильтрация устройств по имени
//    var filteredDevices: [LanDevice] {
//        if viewModel.searchText.isEmpty {
//            return viewModel.connectedDevices
//        } else {
//            return viewModel.connectedDevices.filter { $0.name.lowercased().contains(viewModel.searchText.lowercased()) }
//        }
//    }
//    
//    var body: some View {
//        ZStack {
//            NavigationView {
//                VStack(alignment: .leading) {
//                    // Верхняя часть с заголовком и кнопкой перезагрузки
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text(viewModel.title)
//                                .font(.title)
//                                .fontWeight(.bold)
//                            Spacer()
//                            Button(action: {
//                                viewModel.reload()
//                            }) {
//                                Image(systemName: "arrow.clockwise")
//                                    .foregroundColor(viewModel.isScanning ? .gray : .blue)
//                            }
//                            .disabled(viewModel.isScanning) // Отключено во время сканирования
//                            .accessibilityLabel("Перезапустить сканирование")
//                        }
//                        .padding([.leading, .trailing], 20)
//                        
//                        // Индикатор прогресса
//                        ProgressView(value: viewModel.progress)
//                            .progressViewStyle(LinearProgressViewStyle(tint: .blue))
//                            .padding([.leading, .trailing], 20)
//                    }
//                    .padding(.top, 10)
//                    
//                    // Выбор времени сканирования
//                    VStack(alignment: .leading) {
//                        Text("Время сканирования: \(Int(viewModel.scanDuration)) секунд")
//                            .font(.headline)
//                        Slider(value: $viewModel.scanDuration, in: 10...60, step: 5)
//                            .accentColor(.blue)
//                    }
//                    .padding([.leading, .trailing], 20)
//                    .padding(.top, 10)
//                    
//                    // Список обнаруженных устройств
//                    List(filteredDevices) { device in
//                        NavigationLink(destination: LanDeviceDetailView(device: device)) {
//                            HStack {
//                                // Иконка устройства
//                                Image(systemName: "desktopcomputer")
//                                    .resizable()
//                                    .frame(width: 30, height: 30)
//                                    .foregroundColor(.green)
//                                    .padding(.trailing, 10)
//                                
//                                VStack(alignment: .leading, spacing: 5) {
//                                    Text(device.name)
//                                        .font(.headline)
//                                        .foregroundColor(.primary)
//                                    
//                                    Text("MAC: \(device.mac)")
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                    
//                                    Text("Бренд: \(device.brand)")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                    
//                                    Text("IP: \(device.ipAddress)")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                }
//                            }
//                            .padding(.vertical, 5)
//                        }
//                        .contextMenu {
//                            Button(action: {
//                                UIPasteboard.general.string = device.name
//                                viewModel.showToast(message: "Имя устройства скопировано")
//                            }) {
//                                Text("Скопировать имя")
//                                Image(systemName: "doc.on.doc")
//                            }
//                            
//                            Button(action: {
//                                UIPasteboard.general.string = device.mac
//                                viewModel.showToast(message: "MAC-адрес скопирован")
//                            }) {
//                                Text("Скопировать MAC")
//                                Image(systemName: "doc.on.doc")
//                            }
//                            
//                            Button(action: {
//                                UIPasteboard.general.string = device.ipAddress
//                                viewModel.showToast(message: "IP-адрес скопирован")
//                            }) {
//                                Text("Скопировать IP")
//                                Image(systemName: "doc.on.doc")
//                            }
//                        }
//                    }
//                    .listStyle(PlainListStyle())
//                }
//                .navigationTitle("LAN Scanner")
//                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Поиск устройств")
//                .alert(isPresented: $viewModel.showAlert) {
//                    Alert(
//                        title: Text(viewModel.alertMessage.contains("Нет доступа") ? "Ошибка" : "Сканирование завершено"),
//                        message: Text(viewModel.alertMessage),
//                        dismissButton: .default(Text("OK"))
//                    )
//                }
//                .alert(isPresented: $viewModel.showErrorAlert) {
//                    Alert(
//                        title: Text("Ошибка"),
//                        message: Text(viewModel.errorMessage),
//                        dismissButton: .default(Text("OK"))
//                    )
//                }
//            }
//            
//            // Toast уведомление
//            if viewModel.showToast {
//                VStack {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Text(viewModel.toastMessage)
//                            .padding()
//                            .background(Color.black.opacity(0.7))
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .padding(.bottom, 50)
//                        Spacer()
//                    }
//                    .transition(.slide)
//                    .animation(.easeInOut, value: viewModel.showToast)
//                }
//            }
//        }
//    }
//}
