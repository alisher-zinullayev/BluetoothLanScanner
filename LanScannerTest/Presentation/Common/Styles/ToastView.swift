//
//  ToastView.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 12.01.2025.
//

import Foundation
import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(message)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom, 50)
                Spacer()
            }
            .transition(.slide)
            .animation(.easeInOut, value: message)
        }
    }
}
