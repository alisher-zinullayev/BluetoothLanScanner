//
//  ScanHistoryViewModel.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 12.01.2025.
//

import SwiftUI

final class ScanHistoryViewModel: ObservableObject {
    @Published var sessions: [ScanSession] = []
    @Published var selectedDate: Date = Date()
    
    private let coordinator: ScanHistoryCoordinatorProtocol

    init(coordinator: ScanHistoryCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func onAppear() {
        reloadSessions(for: selectedDate)
    }

    func reloadSessions(for date: Date) {
        sessions = CoreDataManager.shared.fetchScanSessions(on: date)
    }

    @MainActor func showSessionDetails(session: ScanSession) {
        coordinator.showSessionDetails(session: session)
    }
}
