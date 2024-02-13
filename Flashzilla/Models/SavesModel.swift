//
//  SavesModel.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import Foundation

protocol SavesModel {
    func save(cards: [Card])
    func load() -> [Card]
}

extension SavesModel {
    var savedKey: String { "Cards" }
    
    func save(cards: [Card]) {
        FileManager()
            .saveInDocuments(to: savedKey, data: cards)
    }
    
    func load() -> [Card] {
        if FileManager().fileInDocumentsExists(savedKey) {
            let loadedCards: [Card] = FileManager()
                .loadFromDocuments(savedKey)
            return loadedCards
        }
        return []
    }
}
