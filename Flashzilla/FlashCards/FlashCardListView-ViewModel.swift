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
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        var cards = [Card]()
        let title = "All Cards"
        
        
        var selectedCard: Card? = nil
        var showingEditCard = false
        var showingAddCard = false
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
        
        func add(prompt: String, answer: String) {
            modelContext.insert(Card(prompt: prompt, answer: answer))
        }
        
        func remove(index: Int) {
            let card = cards[index]
            remove(card: card)
        }
        
        func remove(card: Card) {
            modelContext.delete(card)
        }
        
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Card>(sortBy: [SortDescriptor(\.prompt)])
                cards = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
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
}
