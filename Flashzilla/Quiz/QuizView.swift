//
//  QuizView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import SwiftUI
import SwiftData

struct QuizView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State private var viewModel: ViewModel
    
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
                    if viewModel.cards.isEmpty == false {
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
    
    init(modelContext: ModelContext) {
        let viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    // Workaround to avoid the warning "... loses global actor"
    private func resetCards() {
        viewModel.resetCards()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Card.self, configurations: config)
    
    for card in Card.examples {
        container.mainContext.insert(card)
    }
    
    return QuizView(modelContext: container.mainContext)
}
