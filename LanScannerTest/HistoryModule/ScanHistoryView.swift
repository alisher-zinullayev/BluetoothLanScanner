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

    init(coordinator: ScanHistoryCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        List(sessions, id: \.id) { session in
            Button(action: {
                coordinator.showSessionDetails(session: session)
            }) {
                Text(session.timestamp?.formatted() ?? "Unknown Date")
                    .foregroundColor(.primary)
            }
        }
        .navigationTitle("Scan History")
        .onAppear {
            sessions = CoreDataManager.shared.fetchScanSessions()
        }
    }
}
