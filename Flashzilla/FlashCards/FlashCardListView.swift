//
//  FlashCardListView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import SwiftUI

struct FlashCardListView: View {

    @EnvironmentObject private var cardsWrapper: CardWrapper
    @StateObject var viewModel: ViewModel = ViewModel()
    
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
                }
            }
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.showingAddCard = true
                    } label: {
                        Image(systemName: "plus")
                            .tint(Color.designSystem.primary)
                    }
                }
            }
            .onAppear {
                viewModel.wrapper = cardsWrapper
            }
            .sheet(isPresented: $viewModel.showingAddCard, content: {
                AddFlashCardView { prompt, answer in
                    viewModel.add(prompt: prompt, answer: answer)
                }
            })
        }
    }
}

// This will be a problem for the preview bc we are not injecting dummy data and its trying to load the actual thing
#Preview {
    FlashCardListView()
        .environmentObject(CardWrapper())
}
