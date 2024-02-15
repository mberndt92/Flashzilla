//
//  PrimaryButton.swift
//  LoanCalculator
//
//  Created by Maximilian Berndt on 2023/05/06.
//

import Foundation
import SwiftUI

struct PrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .background(Color.designSystem.primary)
            .foregroundColor(.white)
            .cornerRadius(25)
            .shadow(radius: Shadows.regular.rawValue)
    }
}

extension View {
    func primaryButton() -> some View {
        self.modifier(PrimaryButton())
    }
}
