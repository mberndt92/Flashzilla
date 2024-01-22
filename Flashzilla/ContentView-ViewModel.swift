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
        
        init(cards: [Card]) {
            self.cards = cards
        }
    }
}
