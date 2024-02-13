//
//  QuizView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @StateObject private var viewModel = ViewModel(cards: [])
    
    init(cards: [Card]) {
        _viewModel = StateObject(wrappedValue: ViewModel(cards: cards))
    }
    
    var shouldShowAccessibilityView: Bool {
        return differentiateWithoutColor || voiceOverEnabled
    }
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 5) {
                ZStack {
                    ForEach(0..<viewModel.cards.count, id: \.self) { index in
                        CardView(card: viewModel.cards[index]) {
                            withAnimation {
                                viewModel.removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: viewModel.cards.count)
                        .allowsHitTesting(index == viewModel.cards.count - 1)
                        .accessibilityHidden(index < viewModel.cards.count - 1)
                    }
                }
                
                if viewModel.cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        viewModel.showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.75))
                            .clipShape(Circle())
                    }
                }
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding()
                
                Spacer()
            }
            
            if shouldShowAccessibilityView {
                QuizViewAccessibility(removeCardClosure: {
                    viewModel.removeCard(at: viewModel.cards.count - 1)
                })
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if viewModel.cards.isEmpty == false {
                    viewModel.isActive = true
                }
            } else {
                viewModel.isActive = false
            }
        }
        .sheet(
            isPresented: $viewModel.showingEditScreen,
            onDismiss: viewModel.resetCards,
            content: EditCards.init
        )
        .onAppear(perform: viewModel.resetCards)
    }
    
    // Workaround to avoid the warning "... loses global actor"
    private func resetCards() {
        viewModel.resetCards()
    }
}

#Preview {
    QuizView(cards: Card.examples)
}
