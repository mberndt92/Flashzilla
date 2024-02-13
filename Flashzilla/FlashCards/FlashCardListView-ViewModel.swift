//
//  FlashCardListView-ViewModel.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import Foundation

extension FlashCardListView {
    @MainActor class ViewModel: ObservableObject {
        let title = "All Cards"
        
        @Published var wrapper: CardWrapper = CardWrapper()
        @Published var selectedCard: Card? = nil
        @Published var showingEditCard = false
        @Published var showingAddCard = false
        
        var cards: [Card] {
            wrapper.cards
        }
        
        func add(prompt: String, answer: String) {
            wrapper.add(Card(prompt: prompt, answer: answer))
        }
        
        func remove(card: Card) {
            wrapper.remove(card)
        }
    }
}
