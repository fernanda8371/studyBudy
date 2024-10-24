//
//  TestApplyView.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import SwiftUI

struct TestApplyView: View {
    @State private var vm = CardViewModel()
    @State private var cardTexts: [String] = [] // Array para almacenar los textos de las tarjetas
    
    var body: some View {
        ZStack {
            // Fondo con un degradado
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
                
                // Carousel de flashcards
                if !cardTexts.isEmpty {
                    TabView {
                        ForEach(Array(zip(vm.cards.indices, vm.cards)), id: \.1.id) { index, card in
                            ExampleFlashCard(text: $cardTexts[index])
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(height: 700)
                    .padding(.bottom, 20)
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
    TestApplyView()
}
