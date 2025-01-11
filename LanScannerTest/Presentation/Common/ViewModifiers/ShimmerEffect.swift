//
//  ShimmerEffect.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import Foundation
import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = -1

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.7), Color.white.opacity(0.3)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: geometry.size.width * 2, height: geometry.size.height)
                        .offset(x: phase * geometry.size.width - geometry.size.width)
                        .onAppear {
                            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                phase = 2
                            }
                        }
                    }
                }
                .mask(content)
            )
    }
}
