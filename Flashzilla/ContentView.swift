//
//  ContentView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 2023/05/05.
//

import SwiftUI
import SwiftData

enum AllTabs: String {
    case list = "list"
    case quiz = "quiz"
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var selection = AllTabs.list.rawValue
    
    var body: some View {
        TabView(selection: $selection) {
            FlashCardListView()
                .tabItem {
                    Label(Translations.listTabTitle, systemImage: "list.bullet")
                }
                .tag(AllTabs.list.rawValue)
            QuizView()
                .tabItem {
                    Label(Translations.quizTabTitle, systemImage: "plus.circle.fill")
                }
                .tag(AllTabs.quiz.rawValue)
        }
        .tint(.designSystem.primary)
        .background(Color.designSystem.elevation)
        .modelContext(modelContext)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Card.self, configurations: config)
    
    for card in Card.examples {
        container.mainContext.insert(card)
    }
    
    return ContentView()
        .modelContainer(container)
}
