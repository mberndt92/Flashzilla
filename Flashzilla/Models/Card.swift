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
    var front: String
    var back: String
    var learningState = LearningState()
    
    init(front: String, back: String) {
        self.front = front
        self.back = back
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Card {
    static let example = Card(front: "Who played the 13th Doctor in Doctor Who?", back: "Jodie Whittaker")
    static let examples: [Card] = [
        Card(front: "apple", back: "a maçã"),
        Card(front: "mango", back: "a manga"),
        Card(front: "pineapple", back: "o abacaxi"),
        Card(front: "papaya", back: "o mamão"),
        Card(front: "watermelon", back: "a melancia"),
        Card(front: "grape", back: "a uva"),
        Card(front: "coconut", back: "o coco")
    ]
}
