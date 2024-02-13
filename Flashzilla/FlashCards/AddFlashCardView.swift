//
//  AddFlashCardView.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 13.02.24.
//

import SwiftUI

struct AddFlashCardView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var prompt = ""
    @State private var answer = ""
    
    @State var onSave: (String, String) -> ()
    
    var body: some View {
        VStack {
            TextField("Prompt", text: $prompt)
            TextField("Answer", text: $answer)
            Button("Save") { onSavePressed() }
        }
    }
    
    private func onSavePressed() {
        let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces)
        
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        onSave(trimmedPrompt, trimmedAnswer)
        dismiss()
    }
}

#Preview {
    AddFlashCardView(onSave: { prompt, answer in })
}
