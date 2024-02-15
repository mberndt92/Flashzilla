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
    
    @Environment(\.modelContext) var modelContext
    @Query var initialCards: [Card]
    @State var cards: [Card] = [] // We remove cards from this copy here all the time while swiping
    
    @State var isActive = true
    @State var showingEditScreen = false
    
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
                    if cards.isEmpty == false {
                        ForEach(0..<cards.count, id: \.self) { index in
                            CardView(card: cards[index]) {
                                withAnimation {
                                    removeCard(at: index)
                                }
                            }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                        }
                    }
                }
                
                if cards.isEmpty {
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
                        showingEditScreen = true
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
                    removeCard(at: cards.count - 1)
                })
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(
            isPresented: $showingEditScreen,
            onDismiss: resetCards,
            content: EditCards.init
        )
        .onAppear(perform: resetCards)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Card.self, configurations: config)
    
    for card in Card.examples {
        container.mainContext.insert(card)
    }
    
    return QuizView()
}
