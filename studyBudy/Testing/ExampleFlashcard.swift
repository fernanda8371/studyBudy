//
//  ExampleFlashcard.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import SwiftUI

struct ExampleFlashcard: View {
    @State var cardVM = CardViewModel()
    var backgroundColor: Color = Color.white
    var borderColor: Color? = nil
    var lineColor: Color = Color.gray.opacity(0.4)
    @State private var currentCardText: String = "Cargando..."

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(backgroundColor)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.5)
                        .shadow(radius: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .stroke(borderColor ?? backgroundColor, lineWidth: borderColor != nil ? 2 : 0)
                        )
                        .overlay(
                            ZStack {
                                // Crear líneas en el fondo
                                VStack(spacing: 10) {
                                    Spacer()
                                    ForEach(0..<12) { _ in
                                        Rectangle()
                                            .fill(lineColor)
                                            .frame(height: 1)
                                            .padding(.horizontal, 15)
                                        Spacer()
                                    }
                                }
                                .padding(.vertical, 10)
                                
                                // Mostrar el texto cargado en un TextEditor
                                TextEditor(text: $currentCardText)
                                    .scrollContentBackground(.hidden)
                                    .lineSpacing(10)
                                    .padding(30)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .opacity(0.9)
                                    .disabled(true) // Deshabilitar edición
                            }
                        )
                        .padding()
                    
                    // Mostrar el texto debajo de la tarjeta
                    Text(currentCardText)
                        .font(.system(size: min(18, geometry.size.width * 0.05), weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(20)
                        .frame(maxWidth: geometry.size.width * 0.85, maxHeight: geometry.size.height * 0.45)
                    
                    if cardVM.isLoading {
                        ProgressView("Cargando tarjetas...")
                    } else if let errorMessage = cardVM.errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(height: 300)
        .onAppear {
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
    ExampleFlashcard()
}
