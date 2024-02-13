//
//  CardOverview.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 25.01.24.
//

import SwiftUI

/**
 Minimum:
 - Shows the list of cards
 - On clicking on a list item, goes to edit mode for that item
 - Swip to delete
 - Edit to delete
 
 Later
 - Allow filtering for tags once tags are available
 */

struct CardOverview: View {
    
    var cards: [Card]
    
    var body: some View {
        NavigationView {
            VStack {
                if (cards.isEmpty) {
                    Text("No cards added yet")
                }
                
                List {
                    ForEach(cards, id: \.prompt) { card in
                        VStack(alignment: .trailing) {
                            HStack {
                                Text(card.prompt)
                                    .font(.footnote)
                                    .background(Color.green)
                                Text(card.answer)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .background(Color.yellow)
                            }
                            .frame(width: .infinity)
                            .background(Color.orange)
                        }
                    }
                }
            }
        }
    }
}

struct CardOverview_Previews: PreviewProvider {
    static var previews: some View {
        CardOverview(cards: [Card.example])
    }
}
