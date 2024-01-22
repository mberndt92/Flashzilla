//
//  ContentView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 2023/05/05.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @StateObject private var viewModel = ViewModel(cards: [])
    
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
            
            if differentiateWithoutColor || voiceOverEnabled {
                ContentViewAccessibility(removeCardClosure: {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
