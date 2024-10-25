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
    @State private var correctAnswers: Int = 0 // Contador de respuestas correctas
    @State private var quizFinished: Bool = false // Indica si el quiz ha terminado
    
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
                } else if quizFinished {
                    // Show the final result when the quiz is finished
                    VStack(spacing: 20) {
                        Text("¡Has terminado el quiz!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                        
                        Text("Respuestas correctas: \(correctAnswers) de \(quizVM.quizes.first?.text.count ?? 0)")
                            .font(.system(size: 24))
                            .foregroundColor(Color(hex: "#21548D"))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding(.horizontal, 16)
                        
                        Button(action: {
                            restartQuiz()
                        }) {
                            Text("Reiniciar Quiz")
                                .font(.system(size: 18, weight: .bold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 20)
                        .padding(.horizontal, 18)
                        .frame(width: 365)
                    }
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
                        // Solo muestra anterior despues de la primera respuesta
                        if currentIndex > 0 {
                            Button(action: {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    answerResult = nil //cuando te regresas borra la respuesta
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
                                answerResult = nil
                            } else {
                                quizFinished = true 
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
    public func checkAnswer(selected: String, correct: String) {
        let normalizedCorrect = correct.lowercased()
        let normalizedSelected = selected.lowercased()
        
        if normalizedSelected == normalizedCorrect {
            answerResult = "Correcto"
            correctAnswers += 1
        } else {
            answerResult = "Incorrecto"
        }
    }
    
    // Función para reiniciar el quiz
    private func restartQuiz() {
        currentIndex = 0
        correctAnswers = 0
        answerResult = nil
        quizFinished = false
    }
}

#Preview {
    QuizView()
}
