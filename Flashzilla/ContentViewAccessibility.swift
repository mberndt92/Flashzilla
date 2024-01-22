//
//  ContentViewAccessibility.swift
//  Flashzilla
//
//  Created by Maximilian Berndt on 22.01.24.
//

import SwiftUI

struct ContentViewAccessibility: View {
    
    var removeCardClosure: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button {
                    withAnimation {
                        removeCardClosure()
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(Circle())
                }
                .accessibilityLabel("Wrong")
                .accessibilityHint("Mark your answer as being incorrect")
                
                Spacer()
                
                Button {
                    withAnimation {
                    }
                } label: {
                    Image(systemName: "checkmark.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(Circle())
                }
                .accessibilityLabel("Correct")
                .accessibilityHint("Mark your answer as being correct")
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
        }
    }
}

struct ContentViewAccessibility_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewAccessibility(removeCardClosure: {})
    }
}
