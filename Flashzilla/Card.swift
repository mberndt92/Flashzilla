//
//  Card.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 2023/05/05.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
}

extension Card {
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
