//
//  FlashCards.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 23/10/24.
//

import SwiftUI

struct FlashCards: View {
    @State private var vm = CardViewModel()
    @State private var cardTexts: [String] = []
    @State private var newCardText = ""

    var body: some View {
        ZStack {
            // Fondo con un degradado
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#21548D"), Color(hex: "#4A90E2")]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("Crea tus Flash Cards para autoestudio!")
                    .font(.system(size: UIScreen.main.bounds.width < 600 ? 30 : 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                
                // Carousel de flashcards
                if !cardTexts.isEmpty {
                    ZStack(alignment: .topTrailing) {
                        TabView {
                            ForEach(Array(zip(vm.cards.indices, vm.cards)), id: \.1.id) { index, card in
                                FlashCard(text: $cardTexts[index])
                                    .frame(width: UIScreen.main.bounds.width * 0.85, height: 570)
                                    .cornerRadius(20)
                                    .padding(.horizontal, 10)
    
                            }
                            .padding(.bottom, 50)
                        }
                        
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .frame(height: 550) // Ajusta el tamaño según el dispositivo
                        

                        // Botón para añadir una nueva tarjeta
                        Button(action: {
                            // Añadir la nueva tarjeta al inicio del array
                            let newCard = newCardText.isEmpty ? "Nueva tarjeta" : newCardText
                            cardTexts.insert(newCard, at: 0)
                            //vm.addFlashCard(newText: newCard)
                            newCardText = "" // Limpiar el texto después de agregar
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 45))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        .offset(y: -65) // Ajusta la posición del botón
                        .padding(.trailing, UIScreen.main.bounds.width < 600 ? 20 : 70)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                }

                // Mostrar un progress view si está cargando
                if vm.isLoading {
                    ProgressView()
                        .padding(.top, 20)
                }
                
                // Mostrar mensaje de error si hay alguno
                if let errorMessage = vm.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding(.top, 20)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            Task {
                await vm.fetchAllCards()
                // Inicializar el array cardTexts con los textos de las tarjetas
                cardTexts = vm.cards.map { $0.text }
            }
        }
    }
}

#Preview {
    FlashCards()
}
