//
//  ScanHistoryView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import SwiftUI

//struct ScanHistoryView: View {
//    @State private var sessions: [ScanSession] = []
//
//    var body: some View {
//        NavigationView {
//            List(sessions, id: \.id) { session in
//                NavigationLink(
//                    destination: SessionDetailView(session: session)
//                ) {
//                    Text(session.timestamp?.formatted() ?? "Unknown Date")
//                }
//            }
//            .navigationTitle("Scan History")
//            .onAppear {
//                sessions = CoreDataManager.shared.fetchScanSessions()
//            }
//        }
//    }
//}

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
