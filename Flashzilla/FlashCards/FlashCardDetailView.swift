//
//  FlashCardDetailView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 27.02.24.
//

import SwiftUI

struct FlashCardDetailView: View {
    
    let card: Card
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Front: \(card.front)")
                Text("Back: \(card.back)")
                Text("Tags: \(card.tags.joined(separator: ", "))")
            }
        }
    }
}

#Preview {
    FlashCardDetailView(card: Card.example)
}
