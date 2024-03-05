//
//  FlashCardListView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import SwiftUI
import SwiftData

struct FlashCardListView: View {
    
    let title = "All Cards"
    
    @Environment(\.modelContext) var modelContext
    @Query var cards: [Card]
    
    @State var selectedCard: Card?
    @State var showingCardDetail = false
    @State var showingAddCard = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(cards) { card in
                        HStack {
                            Text(card.front)
                            Spacer()
                            Text(card.back)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedCard = card
                            showingCardDetail = true
                        }
                        .swipeActions(allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                remove(card: card)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            // this is needed despite the role .destructive... -.-
                            .tint(Color.designSystem.destructive)
                            
                            Button {
                                selectedCard = card
                                showingCardDetail = true
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(Color.designSystem.primary)
                        }
                    }
                    .onDelete(perform: remove) // not used yet as edit mode isn't added
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        if isTesting {
                            addExample()
                        } else {
                            showingAddCard = true
                        }
                        
                    } label: {
                        Image(systemName: "plus")
                            .tint(Color.designSystem.primary)
                    }
                }
                if isTesting {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            addExamples()
                        } label: {
                            Image(systemName: "testtube.2")
                                .tint(Color.designSystem.primary)
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            removeAll()
                        } label: {
                            Image(systemName: "trash.circle")
                                .tint(Color.designSystem.primary)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddCard, content: {
                AddFlashCardView { front, back, tags in
                    add(front: front, back: back, tags: tags)
                }
            })
            .sheet(item: $selectedCard, content: { selectedCard in
                FlashCardDetailView(card: selectedCard)
            })
        }
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
    
    return FlashCardListView()
        .modelContainer(container)
}
