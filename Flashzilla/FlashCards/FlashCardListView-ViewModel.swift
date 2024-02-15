//
//  FlashCardListView-ViewModel.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import Foundation
import SwiftUI
import SwiftData

extension FlashCardListView {
    
    func add(prompt: String, answer: String) {
        modelContext.insert(Card(prompt: prompt, answer: answer))
    }
    
    func remove(index: Int) {
        let card = cards[index]
        remove(card: card)
    }
    
    func remove(_ indexSet: IndexSet) {
        for index in indexSet {
            remove(index: index)
        }
    }
    
    func remove(card: Card) {
        modelContext.delete(card)
    }
    
    func addExample() {
        modelContext.insert(Card.example)
    }
    
    func addExamples() {
        for card in Card.examples {
            modelContext.insert(card)
        }
    }
    
    func removeAll() {
        for card in cards {
            modelContext.delete(card)
        }
    }
}
