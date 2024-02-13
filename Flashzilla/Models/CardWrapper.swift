//
//  CardWrapper.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import Foundation

@MainActor class CardWrapper: ObservableObject {
    
    @Published var cards: [Card] = []
    let savedKey = "Cards"
    
    init() {
        load()
    }
    
    func add(_ card: Card) {
        cards.append(card)
        save()
    }
    
    func remove(_ card: Card) {
        let firstIndex = cards.firstIndex(of: card)!
        cards.remove(atOffsets: IndexSet(integer: firstIndex))
        save()
    }
    
    private func save() {
        FileManager()
            .saveInDocuments(to: savedKey, data: cards)
    }
    
    private func load() {
        if FileManager().fileInDocumentsExists(savedKey) {
            let loadedCards: [Card] = FileManager()
                .loadFromDocuments(savedKey)
            cards = loadedCards
        }
    }
}
