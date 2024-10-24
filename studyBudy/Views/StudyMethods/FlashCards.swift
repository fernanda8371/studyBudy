//
//  FlashCards.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 23/10/24.
//

import SwiftUI

struct FlashCards: View {
    @State private var cardTexts = Array(repeating: "Sample flashcard text", count: 5)
    
    var body: some View {
        ZStack {
            // Background color with gradient effect
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#21548D"), Color(hex: "#4A90E2")]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack() { 

                Text("Crea tus Flash Cards para autoestudio!")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
                // Carousel of flashcards
                TabView {
                    ForEach(0..<cardTexts.count, id: \.self) { index in
                        FlashCard(text: $cardTexts[index])
                            .padding(.horizontal, 20)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .padding(.bottom, 20)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    FlashCards()
}

