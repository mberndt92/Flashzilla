//
//  CardStatistics.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 16.02.24.
//

import Foundation

class CardStatistics {
    private (set) var correct: Int = 0
    private (set) var wrong: Int = 0
    
    var seen: Int {
        correct + wrong // let's ignore cheaters
    }
    
    var successRatio: Double {
        Double(correct / (correct + wrong))
    }
    
    func answeredCorrectly() {
        correct += 1
    }
    
    func answeredIncorrectly() {
        wrong += 1
    }
    
    func reset() {
        correct = 0
        wrong = 0
    }
}
