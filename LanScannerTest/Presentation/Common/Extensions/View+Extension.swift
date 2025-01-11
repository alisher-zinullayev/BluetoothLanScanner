//
//  View+Extension.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 11.01.2025.
//

import Foundation
import SwiftUI

extension View {
    func `if`<Content: View>(_ condition: Bool, apply: (Self) -> Content) -> some View {
        if condition {
            return apply(self)
        } else {
            return self
        }
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerEffect())
    }
}
