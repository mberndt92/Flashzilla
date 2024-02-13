//
//  ContentView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 2023/05/05.
//

import SwiftUI

enum AllTabs: String {
    case list = "list"
    case quiz = "quiz"
}

struct ContentView: View {
    @State private var selection = AllTabs.list.rawValue
    @StateObject var cardsWrapper = CardWrapper()
    
    var body: some View {
        TabView(selection: $selection) {
            FlashCardListView()
                .tabItem {
                    Label(Translations.cardListTitle, systemImage: "list.bullet")
                }
                .tag(AllTabs.list.rawValue)
            QuizView(cards: cardsWrapper.cards)
                .tabItem {
                    Label(Translations.quizViewTitle, systemImage: "plus.circle.fill")
                }
                .tag(AllTabs.quiz.rawValue)
        }
        .tint(.designSystem.primary)
        .environmentObject(cardsWrapper)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
