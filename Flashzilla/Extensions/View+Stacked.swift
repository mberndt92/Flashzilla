//
//  View+Stacked.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
