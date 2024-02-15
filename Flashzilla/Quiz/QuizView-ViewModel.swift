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
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        
        var isActive = true
        var showingEditScreen = false
        
        var cards: [Card] = []
        
        private var initialCards = [Card]()
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
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
            fetchData() // so we can assure, any additions/deletions/edits will also be reflected
        }
        
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Card>()
                initialCards = try modelContext.fetch(descriptor).shuffled()
                cards = initialCards
            } catch {
                print("Fetch failed")
            }
        }
    }
}
