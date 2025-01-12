//
//  TintColor.swift
//  LanScannerTest
//
//  Created by Alisher Zinullayev on 12.01.2025.
//

import Foundation
import SwiftUI

struct TintColor: ViewModifier {

    let color: Color

    func body(content: Content) -> some View {
        if #available(iOS 16.1, *) {
            content
                .tint(color)
        } else {
            content
                .accentColor(color)
        }
    }
}
