//
//  AddFlashCardView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import SwiftUI

struct AddFlashCardView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var front = ""
    @State private var back = ""
    @State private var tags = ""
    
    @State var onSave: (String, String, [String]) -> ()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Front", text: $front)
                TextField("Back", text: $back)
                TextField("Tags", text: $tags)
            }
            .toolbar {
                Button("Save") {
                    onSavePressed()
                }
            }
            .navigationTitle("Add Flashcard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func onSavePressed() {
        let trimmedPrompt = front.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = back.trimmingCharacters(in: .whitespaces)
        let separatedTags = tags.trimmingCharacters(in: .whitespaces).components(separatedBy: ",")
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        onSave(trimmedPrompt, trimmedAnswer, separatedTags)
        dismiss()
    }
}

#Preview {
    AddFlashCardView(onSave: { prompt, answer, tags in })
}
