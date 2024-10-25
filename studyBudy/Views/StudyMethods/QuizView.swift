//
//  QuizView.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 24/10/24.
//

import SwiftUI

struct QuizView: View {
    @State private var quizVM = QuizViewModel()
    @State private var currentIndex: Int = 0 // Índice para la pregunta actual
    @State private var answerResult: String? = nil // Estado para mostrar si es correcto o incorrecto
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#21548D"), Color(hex: "#4A90E2")]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                
                Text("Quiz")
                    .font(.system(size: 50))
                    .foregroundStyle(Color.white)
                    .bold()
                    .padding(.bottom, 30)
                if quizVM.isLoading {
                    ProgressView("Cargando quizzes...")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                } else if let errorMessage = quizVM.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal)
                } else if let firstQuiz = quizVM.quizes.first, currentIndex < firstQuiz.text.count {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Pregunta \(currentIndex + 1)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(hex: "#21548D"))
                            .padding()
                        
                        Text(firstQuiz.text[currentIndex])
                            .font(.system(size: 20))
                            .foregroundColor(Color(hex: "#21548D"))
                            .padding()
                        //.background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                        
                        HStack(spacing: 15) {
                            Button(action: {
                                checkAnswer(selected: "Verdadero", correct: firstQuiz.answer[currentIndex])
                            }) {
                                Text("Verdadero")
                                    .font(.system(size: 18, weight: .bold))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green.opacity(0.8))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            }
                            
                            Button(action: {
                                checkAnswer(selected: "Falso", correct: firstQuiz.answer[currentIndex])
                            }) {
                                Text("Falso")
                                    .font(.system(size: 18, weight: .bold))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red.opacity(0.8))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(15)
                    .padding(.horizontal, 16)
                    
                    HStack(spacing: 15) {
                        // Show "Anterior" only if it's not the first question
                        if currentIndex > 0 {
                            Button(action: {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    answerResult = nil // Clear result when going back
                                }
                            }) {
                                Text("Anterior")
                                    .font(.system(size: 18, weight: .bold))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray.opacity(0.8))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            }
                        }
                        
                        // Always show "Siguiente"
                        Button(action: {
                            if currentIndex < firstQuiz.text.count - 1 {
                                currentIndex += 1
                                answerResult = nil // Clear result when moving to the next question
                            } else {
                                print("Terminaste el quiz")
                            }
                        }) {
                            Text("Siguiente")
                                .font(.system(size: 18, weight: .bold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 18)
                } else {
                    Text("No hay preguntas disponibles")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                }
                
            }
            .onAppear {
                Task {
                    await quizVM.fetchAllQuizes()
                }
            }
            .navigationTitle("Quizzes")
            .padding(.horizontal, 30)
        }
    }
    
    // Función para verificar la respuesta
    private func checkAnswer(selected: String, correct: String) {
        let normalizedCorrect = correct.lowercased()
        let normalizedSelected = selected.lowercased()
        
        if normalizedSelected == normalizedCorrect {
            answerResult = "Correcto"
        } else {
            answerResult = "Incorrecto"
        }
    }
}

#Preview {
    QuizView()
}
