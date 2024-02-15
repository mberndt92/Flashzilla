//
//  QuizView-ViewModel.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 22.01.24.
//

import Foundation
import SwiftUI
import SwiftData

extension QuizView {
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        isActive = true
        cards = initialCards
    }
}
