//
//  ContentView-ViewModel.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 22.01.24.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var cards: [Card]
        @Published var isActive = true
        @Published var showingEditScreen = false
        
        init(cards: [Card]) {
            self.cards = cards
        }
        
        func loadData() {
            if let data = UserDefaults.standard.data(forKey: "Cards") {
                if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                    cards = decoded
                }
            }
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
            loadData()
        }
    }
}
