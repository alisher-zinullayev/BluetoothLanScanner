//
//  ScanHistoryView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

struct ScanHistoryView: View {
    private let coordinator: ScanHistoryCoordinator
    @State private var sessions: [ScanSession] = []
    
    @State private var selectedDate = Date()

    init(coordinator: ScanHistoryCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
            VStack {
                dateFilter
                
                List(sessions, id: \.id) { session in
                    Button(action: {
                        coordinator.showSessionDetails(session: session)
                    }) {
                        Text(session.timestamp?.formatted() ?? "Unknown Date")
                            .foregroundColor(.primary)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Scan History")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                reloadSessions(for: selectedDate)
            }
        }
        
        private var dateFilter: some View {
            HStack {
                DatePicker(
                    "Выберите дату:",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
                
                Button("Фильтровать") {
                    reloadSessions(for: selectedDate)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    
        private func reloadSessions(for date: Date) {
            sessions = CoreDataManager.shared.fetchScanSessions(on: date)
        }
}
