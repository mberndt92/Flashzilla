//
//  Card.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 2023/05/05.
//

import Foundation
import SwiftData

@Model
class Card: Identifiable, Equatable {
    var id: UUID = UUID()
    var prompt: String
    var answer: String
    
    init(prompt: String, answer: String) {
        self.prompt = prompt
        self.answer = answer
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Card {
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    static let examples: [Card] = [
        Card(prompt: "apple", answer: "a maçã"),
        Card(prompt: "mango", answer: "a manga"),
        Card(prompt: "pineapple", answer: "o abacaxi"),
        Card(prompt: "papaya", answer: "o mamão"),
        Card(prompt: "watermelon", answer: "a melancia"),
        Card(prompt: "grape", answer: "a uva"),
        Card(prompt: "coconut", answer: "o coco")
    ]
}
