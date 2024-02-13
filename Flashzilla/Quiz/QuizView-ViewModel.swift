//
//  QuizView-ViewModel.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 22.01.24.
//

import Foundation

extension QuizView {
    @MainActor class ViewModel: ObservableObject {
        let initialCards: [Card]
        @Published var cards: [Card]
        @Published var isActive = true
        @Published var showingEditScreen = false
        
        init(cards: [Card]) {
            self.cards = cards
            self.initialCards = cards
        }
        
        func removeCard(at index: Int) {
            guard index >= 0 else { return }
            cards.remove(at: index)
            
            if cards.isEmpty {
                isActive = false
            }
        }
        
        func resetCards() {
            isActive = true
            cards = initialCards.shuffled()
        }
    }
}
