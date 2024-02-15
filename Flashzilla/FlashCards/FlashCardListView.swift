//
//  FlashCardListView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import SwiftUI
import SwiftData

struct FlashCardListView: View {
    @State private var viewModel: ViewModel
//    @Query var cards: [Card]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.cards) { card in
                        HStack {
                            Text(card.prompt)
                            Spacer()
                            Text(card.answer)
                        }
                        .swipeActions(allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                viewModel.remove(card: card)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            // this -shouldn't- be needed due to role .destructive
                            .tint(Color.designSystem.destructive)
                            
                            Button {
                                viewModel.selectedCard = card
                                viewModel.showingEditCard = true
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(Color.designSystem.primary)
                        }
                    }
                    .onDelete(perform: deleteCards) // not used yet as edit mode isn't added
                }
            }
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
//                        viewModel.showingAddCard = true
                        viewModel.addExample()
                    } label: {
                        Image(systemName: "plus")
                            .tint(Color.designSystem.primary)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.addExamples()
                    } label: {
                        Image(systemName: "testtube.2")
                            .tint(Color.designSystem.primary)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.removeAll()
                    } label: {
                        Image(systemName: "trash.circle")
                            .tint(Color.designSystem.primary)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddCard, content: {
                AddFlashCardView { prompt, answer in
                    viewModel.add(prompt: prompt, answer: answer)
                }
            })
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
    
    init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    private func deleteCards(_ indexSet: IndexSet) {
        for index in indexSet {
            viewModel.remove(index: index)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Card.self, configurations: config)
    
    for card in Card.examples {
        container.mainContext.insert(card)
    }
    
    return FlashCardListView(modelContext: container.mainContext)
        .modelContainer(container)
}
