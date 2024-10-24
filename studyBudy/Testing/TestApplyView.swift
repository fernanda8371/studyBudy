//
//  TestApplyView.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//


import SwiftUI

struct TestApplyView: View {
    @State private var cardTexts = Array(repeating: "Sample flashcard text", count: 5)
    
    var body: some View {
        ZStack {
            // Background color with gradient effect
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#21548D"), Color(hex: "#4A90E2")]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Crea tus Flash Cards para autoestudio!")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                
                // Carousel of flashcards
                TabView {
                    ForEach(0..<cardTexts.count, id: \.self) { index in
                        ExampleFlashCard()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(height:700)
                .padding(.bottom, 20)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    TestApplyView()
}

