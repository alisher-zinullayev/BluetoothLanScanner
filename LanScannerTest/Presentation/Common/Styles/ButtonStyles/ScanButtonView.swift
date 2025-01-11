//
//  ScanButtonView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import Foundation
import SwiftUI

struct ScanButtonView: View {
    @StateObject var viewModel: BluetoothViewModel

    var body: some View {
        Button(action: {
            viewModel.startScan()
        }) {
            Text(viewModel.isScanning ? "Сканирование..." : "Начать сканирование")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(viewModel.isScanning ? Color.gray : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .if(viewModel.isScanning, apply: { $0.shimmer() })
        }
        .disabled(viewModel.isScanning)
        .animation(.easeInOut, value: viewModel.isScanning)
    }
}

