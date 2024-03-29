//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 2023/05/05.
//

import SwiftUI
import SwiftData

@main
struct FlashzillaApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Card.self)
        } catch {
            fatalError("Failed to create ModelContainer for Card.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
