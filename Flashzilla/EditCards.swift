//
//  EditCards.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 2023/05/05.
//

import SwiftUI

struct EditCards: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var cards = [Card]()
    
    @State private var newFront = ""
    @State private var newBack = ""
    
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Front", text: $newFront)
                    TextField("Back", text: $newBack)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].front)
                                .font(.headline)
                            
                            Text(cards[index].back)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    
    private func done() {
        dismiss()
    }
    
    private func addCard() {
        let trimmedFront = newFront.trimmingCharacters(in: .whitespaces)
        let trimmedBack = newBack.trimmingCharacters(in: .whitespaces)
        
        guard trimmedFront.isEmpty == false && trimmedBack.isEmpty == false else { return }
        
        let card = Card(front: trimmedFront, back: trimmedBack)
        cards.insert(card, at: 0)
        saveData()
        
        newFront = ""
        newBack = ""
    }
    
    private func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    private func loadData() {
//        if let data = UserDefaults.standard.data(forKey: "Cards") {
//            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//                cards = decoded
//            }
//        }
    }
    
    private func saveData() {
//        if let data = try? JSONEncoder().encode(cards) {
//            UserDefaults.standard.set(data, forKey: "Cards")
//        }   
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
