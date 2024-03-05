//
//  QuizMenu.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 27.02.24.
//

import SwiftUI
import SwiftData

struct QuizMenu: View {
    @Query private var cards: [Card]
    @State private var selectedTag: String = "New"
    @State private var allCards = true
    @State private var amountOfCards = 10
    
    @State private var mixBackFront = false
    
    @State private var showingQuiz = false
    
    let options: [Int] = [5, 10, 20, 30, 50]
    
    var body: some View {
        NavigationView {
            List {
                Picker("Choose a Tag", selection: $selectedTag) {
                    ForEach(allTags(cards: cards), id: \.self) {
                        Text($0)
                    }
                }
                Toggle("All cards?", isOn: $allCards.animation())
                if allCards == false {
                    Picker("# of cards", selection: $amountOfCards) {
                        ForEach(options, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                Toggle("Mix Back/Front", isOn: $mixBackFront.animation())
                
                Button("Start") {
                    print("SelectedTag:\(selectedTag)")
                    showingQuiz = true
                }
            }
            .listStyle(.grouped)
            .onAppear(perform: {
                // Workaround for the Picker behaviour for default selection
                if selectedTag.isEmpty {
                  selectedTag = allTags(cards: cards).first ?? "Test"
                }
                print("SelectedTag:\(selectedTag)")
            })
            .sheet(isPresented: $showingQuiz, content: {
                QuizView(
                    cards: filteredCards(
                    cards: cards,
                    tags: [selectedTag],
                    amountOfCards: amountOfCards,
                    mixBackFront: mixBackFront
                )
                )
            })
        }
    }
    
    private func allTags(cards: [Card]) -> [String] {
        return Card.dynamicTags +  Array(Set(cards.flatMap { $0.tags })).sorted() // without sorted, the initial selection will be flaky due to tags[0] in an unsorted list and any change to e.g. # cards refreshing the view
    }
    
    private func filteredCards(
        cards: [Card],
        tags: [String],
        amountOfCards: Int,
        mixBackFront: Bool
    ) -> [Card] {
        
        let finalCards = filterByRegularTag(
            cards: cards,
            tags: tags,
            amountOfCards: amountOfCards,
            mixBackFront: mixBackFront
        )
        
        // TODO: mixBackFront
        
        return finalCards
    }
    
    private func filterByDynamicTag(
        cards: [Card],
        tags: [String],
        amountOfCards: Int,
        mixBackFront: Bool
    ) -> [Card] {
        // TODO implement - not sure how yet
        return []
    }
    
    private func filterByRegularTag(
        cards: [Card],
        tags: [String],
        amountOfCards: Int,
        mixBackFront: Bool
    ) -> [Card] {
        let filteredByTag = cards.compactMap { card in
            return Set(card.tags).isDisjoint(with: tags) ? nil : card
        }
        var finalCards = filteredByTag
        if allCards == false {
            finalCards = []
            var remainingAmount = amountOfCards
            while remainingAmount > 0 {
                let aCard = filteredByTag.randomElement()!
                if finalCards.contains(aCard) == false {
                    finalCards.append(aCard)
                    remainingAmount -= 1
                }
                if Set(finalCards) == Set(filteredByTag) {
                    remainingAmount = -1
                }
            }
        }
        
        // TODO: mixBackFront
        
        return finalCards
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    
    let container = try! ModelContainer(
        for: SpacedRepetitionState.self, CardStatistics.self, Card.self,
        configurations: config
    )
    
    for card in Card.examples {
        container.mainContext.insert(card)
    }
    
    return QuizMenu()
        .modelContainer(container)
}
