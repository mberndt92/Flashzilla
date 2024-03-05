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
    var state: SpacedRepetitionState
    var statistics: CardStatistics
    var tags: [String] = []
    
    static var dynamicTags = ["New", "Review"]
    
    init(front: String, back: String, tags: [String] = []) {
        self.front = front
        self.back = back
        self.tags = tags
        self.state = SpacedRepetitionState()
        self.statistics = CardStatistics()
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Card {
    static let example = Card(front: "watermelon", back: "a melancia")
    static var examples: [Card] = {
        return fruitsAndVegetables
        + colors
        + animals
        + clothing
        + bodyParts
        + daysMonths
        + family
    }()
    
    static let fruits = "Fruits & Vegetables"
    static let fruitsAndVegetables: [Card] = [
        Card(front: "apple", back: "a maçã", tags: [fruits]),
        Card(front: "banana", back: "a banana", tags: [fruits]),
        Card(front: "orange", back: "a laranja", tags: [fruits]),
        Card(front: "mango", back: "a manga", tags: [fruits]),
        Card(front: "pineapple", back: "o abacaxi", tags: [fruits]),
        Card(front: "papaya", back: "o mamão", tags: [fruits]),
        Card(front: "grape", back: "a uva", tags: [fruits]),
        Card(front: "watermelon", back: "a melancia", tags: [fruits]),
        Card(front: "coconut", back: "o coco", tags: [fruits]),
        Card(front: "passion fruit", back: "o maracujá", tags: [fruits]),
        Card(front: "carrot", back: "a cenoura", tags: [fruits]),
        Card(front: "potato", back: "a batata", tags: [fruits]),
        Card(front: "onion", back: "a cebola", tags: [fruits]),
        Card(front: "tomato", back: "o tomate", tags: [fruits]),
        Card(front: "bell pepper", back: "o pimentão", tags: [fruits]),
        Card(front: "cabbage", back: "o repolho", tags: [fruits]),
        Card(front: "lettuce", back: "a alface", tags: [fruits]),
        Card(front: "spinach", back: "o espinafre", tags: [fruits]),
        Card(front: "broccoli", back: "o brócolis", tags: [fruits]),
        Card(front: "cauliflower", back: "a couve-flor", tags: [fruits])
    ]
    
    static let colorTag = "colors"
    static let colors: [Card] = [
        Card(front: "red", back: "vermelho", tags: [colorTag]),
        Card(front: "blue", back: "azul", tags: [colorTag]),
        Card(front: "green", back: "verde", tags: [colorTag]),
        Card(front: "yellow", back: "amarelo", tags: [colorTag]),
        Card(front: "orange", back: "laranja", tags: [colorTag]),
        Card(front: "purple", back: "roxo", tags: [colorTag]),
        Card(front: "pink", back: "rosa", tags: [colorTag]),
        Card(front: "brown", back: "marrom", tags: [colorTag]),
        Card(front: "black", back: "preto", tags: [colorTag]),
        Card(front: "white", back: "branco", tags: [colorTag])
    ]
    
    static let animalTag = "animals"
    static let animals: [Card] = [
        Card(front: "dog", back: "o cachorro", tags: [animalTag]),
        Card(front: "cat", back: "o gato", tags: [animalTag]),
        Card(front: "elephant", back: "o elefante", tags: [animalTag]),
        Card(front: "giraffe", back: "a girafa", tags: [animalTag]),
        Card(front: "lion", back: "o leão", tags: [animalTag]),
        Card(front: "tiger", back: "o tigre", tags: [animalTag]),
        Card(front: "monkey", back: "o macaco", tags: [animalTag]),
        Card(front: "bear", back: "o urso", tags: [animalTag]),
        Card(front: "rabbit", back: "o coelho", tags: [animalTag]),
        Card(front: "bird", back: "o pássaro", tags: [animalTag]),
        Card(front: "fish", back: "o peixe", tags: [animalTag]),
        Card(front: "dolphin", back: "o golfinho", tags: [animalTag]),
        Card(front: "whale", back: "a baleia", tags: [animalTag]),
        Card(front: "snake", back: "a cobra", tags: [animalTag]),
        Card(front: "turtle", back: "a tartaruga", tags: [animalTag]),
        Card(front: "frog", back: "o sapo", tags: [animalTag]),
        Card(front: "butterfly", back: "a borboleta", tags: [animalTag]),
        Card(front: "bee", back: "a abelha", tags: [animalTag]),
        Card(front: "horse", back: "o cavalo", tags: [animalTag]),
        Card(front: "cow", back: "a vaca", tags: [animalTag])
    ]
    
    static let clothingTag = "clothes"
    static let clothing: [Card] = [
        Card(front: "shirt", back: "a camisa", tags: [clothingTag]),
        Card(front: "pants", back: "as calças", tags: [clothingTag]),
        Card(front: "dress", back: "o vestido", tags: [clothingTag]),
        Card(front: "shoes", back: "os sapatos", tags: [clothingTag]),
        Card(front: "hat", back: "o chapéu", tags: [clothingTag]),
        Card(front: "jacket", back: "a jaqueta", tags: [clothingTag]),
        Card(front: "socks", back: "as meias", tags: [clothingTag])
    ]
    
    static let bodyTag = "body parts"
    static let bodyParts: [Card] = [
        Card(front: "head", back: "a cabeça", tags: [bodyTag]),
        Card(front: "eyes", back: "os olhos", tags: [bodyTag]),
        Card(front: "ears", back: "os ouvidos", tags: [bodyTag]),
        Card(front: "nose", back: "o nariz", tags: [bodyTag]),
        Card(front: "mouth", back: "a boca", tags: [bodyTag]),
        Card(front: "hands", back: "as mãos", tags: [bodyTag]),
        Card(front: "fingers", back: "os dedos", tags: [bodyTag]),
        Card(front: "legs", back: "as pernas", tags: [bodyTag]),
        Card(front: "feet", back: "os pés", tags: [bodyTag]),
        Card(front: "heart", back: "o coração", tags: [bodyTag])
    ]
    
    static let daysMonthsTag = "days / months"
    static let daysMonths: [Card] = [
        Card(front: "Monday", back: "a segunda-feira", tags: [daysMonthsTag]),
        Card(front: "Tuesday", back: "a terça-feira", tags: [daysMonthsTag]),
        Card(front: "Wednesday", back: "a quarta-feira", tags: [daysMonthsTag]),
        Card(front: "Thursday", back: "a quinta-feira", tags: [daysMonthsTag]),
        Card(front: "Friday", back: "a sexta-feira", tags: [daysMonthsTag]),
        Card(front: "Saturday", back: "o sabado", tags: [daysMonthsTag]),
        Card(front: "Sunday", back: "o domingo", tags: [daysMonthsTag]),
        // --
        Card(front: "January", back: "o janeiro", tags: [daysMonthsTag]),
        Card(front: "February", back: "o fevereiro", tags: [daysMonthsTag]),
        Card(front: "March", back: "o março", tags: [daysMonthsTag]),
        Card(front: "April", back: "o abril", tags: [daysMonthsTag]),
        Card(front: "May", back: "o maio", tags: [daysMonthsTag]),
        Card(front: "June", back: "o junho", tags: [daysMonthsTag]),
        Card(front: "July", back: "o julho", tags: [daysMonthsTag]),
        Card(front: "August", back: "o agosto", tags: [daysMonthsTag]),
        Card(front: "September", back: "o setembro", tags: [daysMonthsTag]),
        Card(front: "October", back: "o outubro", tags: [daysMonthsTag]),
        Card(front: "November", back: "o novembro", tags: [daysMonthsTag]),
        Card(front: "December", back: "o dezembro", tags: [daysMonthsTag])
    ]
    
    static let familyTag = "family"
    static let family: [Card] = [
        Card(front: "father", back: "pai", tags: [familyTag]),
        Card(front: "mother", back: "mãe", tags: [familyTag]),
        Card(front: "brother", back: "irmão", tags: [familyTag]),
        Card(front: "sister", back: "irmã", tags: [familyTag]),
        Card(front: "son", back: "filho", tags: [familyTag]),
        Card(front: "daugther", back: "filha", tags: [familyTag]),
        Card(front: "grandfather", back: "avô", tags: [familyTag]),
        Card(front: "grandmother", back: "avó", tags: [familyTag]),
        Card(front: "uncle", back: "tio", tags: [familyTag]),
        Card(front: "aunt", back: "tia", tags: [familyTag]),
        Card(front: "cousin (m)", back: "primo", tags: [familyTag]),
        Card(front: "cousin (f)", back: "prima", tags: [familyTag])
    ]
}
