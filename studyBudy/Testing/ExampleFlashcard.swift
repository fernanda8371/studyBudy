//
//  ExampleFlashcard.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import SwiftUI

struct ExampleFlashCard: View {
    @State var cardVM = CardViewModel()
    @State private var currentCardText: String = "Cargando..."
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color.white)
                        .frame(width: geometry.size.width * 0.9, height: 500)
                        .shadow(radius: 5)
                        .overlay(
                            ZStack {
                                // Create liness
                                VStack(spacing: 15) {
                                    ForEach(0..<12) { _ in
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.4))
                                            .frame(height: 1)
                                            .padding(.horizontal, 15)
                                        Spacer()
                                    }
                                }
                                .padding(.vertical, 10)
                                
                                // TextEditor for input
                                TextEditor(text: $currentCardText)
                                    .scrollContentBackground(.hidden)
                                    .lineSpacing(15)
                                    .padding(.horizontal, 30)
                                    .padding(.top, 10)
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: geometry.size.width * 0.85, height: 500)
                            }
                        )
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 500)
        }
        .onAppear(){
            Task {
                await cardVM.fetchAllCards()
                if let firstCard = cardVM.cards.first {
                    currentCardText = firstCard.text
                } else {
                    currentCardText = "No se encontraron tarjetas."
                }
            }
        }
    }
}

#Preview {
    ExampleFlashCard()
}


