//
//  ScanHistoryView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

struct ScanHistoryView: View {
    @StateObject var viewModel: ScanHistoryViewModel
    
    var body: some View {
        VStack {
            dateFilter
            
            List(viewModel.sessions, id: \.id) { session in
                Button(action: {
                    viewModel.showSessionDetails(session: session)
                }) {
                    Text(session.timestamp?.formatted() ?? "Unknown Date")
                }
            }
        }
        .navigationTitle("Scan History")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.onAppear()
        }
    }

    private var dateFilter: some View {
        HStack {
            DatePicker(
                "Выберите дату:",
                selection: $viewModel.selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.compact)
            
            Button("Фильтровать") {
                viewModel.reloadSessions(for: viewModel.selectedDate)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
