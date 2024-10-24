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
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#21548D"), Color(hex: "#4A90E2")]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Crea tus Flash Cards para autoestudio!")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                
                // Carousel of flashcards with a ZStack for the button
                ZStack(alignment: .topTrailing) {
                    // Carousel of flashcards
                    TabView {
                        ForEach(0..<cardTexts.count, id: \.self) { index in
                            FlashCard(text: $cardTexts[index])
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(height: 630)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // Plus button overlaid in the top-right corner
                    Button(action: {
                        cardTexts.append("")
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 45))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    .padding(.trailing,58)
                    .padding(.top, -7)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    FlashCards()
}
