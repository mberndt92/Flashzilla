//
//  Colors+LoanCalculator.swift
//  LoanCalculator
//
//  Created by Maximilian Berndt on 2023/05/05.
//

import Foundation
import SwiftUI

extension Color {
    static let primaryNavyBlue = Color(red: 26/255, green: 46/255, blue: 70/255)
    static let accentTealBlue = Color(red: 48/255, green: 213/255, blue: 200/255)
    static let accentSkyBlue = Color(red: 138/255, green: 205/255, blue: 234/255)
    static let accentLightGray = Color(red: 229/255, green: 229/255, blue: 229/255)
    static let accentDarkGray = Color(red: 45/255, green: 45/255, blue: 45/255)
    
    static let designSystem = DesignSystem.Colors()
}

struct DesignSystem {
    struct Colors {
        let primary = Color("primary")
        let success = Color("success")
        let background = Color("background")
        let foreground = Color("foreground")
        let elevation = Color("elevation")
        let destructive = Color.red
    }
}
