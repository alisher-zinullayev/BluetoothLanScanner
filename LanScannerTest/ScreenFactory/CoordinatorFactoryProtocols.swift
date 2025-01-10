//
//  CoordinatorFactoryProtocols.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 10.01.2025.
//

import Foundation

protocol BluetoothCoordinatorFactory: BluetoothViewFactory {}

protocol LanCoordinatorFactory: LanViewFactory {}

protocol AppCoordinatorFactory: MainCoordinatorViewFactory, BluetoothCoordinatorFactory, LanCoordinatorFactory {}

protocol ScanHistoryCoordinatorFactory: ScanHistoryViewFactory {}
