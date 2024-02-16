//
//  LearningState.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 16.02.24.
//

import Foundation

class LearningState {
    // Spaced Repetition: Days till next review
    enum State: Int {
        case new = 0
        case box1 = 1
        case box2 = 3
        case box3 = 7
        case box4 = 21
        case box5 = 30
        case box6 = 45
        case box7 = 60
        case done = -1
    }
    
    var state: State = .new
    
    var isReadyForReview: Bool {
        guard let nextReview = nextReview else { return false }
        return Calendar.current.isDate(Date.now, equalTo: nextReview, toGranularity: .day)
    }
    
    private var nextReview: Date? = Date.now
    
    func answeredCorrectly() {
        switch state {
        case .new: state = .box1
        case .box1: state = .box2
        case .box2: state = .box3
        case .box3: state = .box4
        case .box4: state = .box5
        case .box5: state = .box6
        case .box6: state = .box7
        default: break
        }
    }
    
    func answeredIncorrectly() {
        switch state {
        case .box1: state = .new
        case .box2: state = .box1
        case .box3: state = .box2
        case .box4: state = .box3
        case .box5: state = .box4
        case .box6: state = .box5
        case .box7: state = .box6
        default: break
        }
    }
    
    private func scheduleNextReview() {
        let now = Date.now
        let target = Calendar.current.date(byAdding: .day, value: state.rawValue, to: now)
        
        if state == .done {
            nextReview = nil
        } else {
            nextReview = target
        }
    }
}
