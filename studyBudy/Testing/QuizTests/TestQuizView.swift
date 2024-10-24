//
//  TestQuizView.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import SwiftUI

struct QuizListView: View {
    @State private var quizVM = QuizViewModel()
    @State private var currentIndex: Int = 0 // Índice para la pregunta actual
    @State private var answerResult: String? = nil // Estado para mostrar si es correcto o incorrecto

    var body: some View {
        VStack {
            if quizVM.isLoading {
                ProgressView("Cargando quizzes...")
            } else if let errorMessage = quizVM.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else if let firstQuiz = quizVM.quizes.first, currentIndex < firstQuiz.text.count {
                // Muestra solo la pregunta actual del primer quiz
                VStack(alignment: .leading, spacing: 10) {
                    Text("Preguntary \(currentIndex + 1)")
                        .font(.headline)
                    
                    Text(firstQuiz.text[currentIndex])
                        .font(.body)
                        .padding(.top, 10)
                    
                    HStack {
                        Button(action: {
                            checkAnswer(selected: "Verdadero", correct: firstQuiz.answer[currentIndex])
                        }) {
                            Text("Verdadero")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            checkAnswer(selected: "Falso", correct: firstQuiz.answer[currentIndex])
                        }) {
                            Text("Falso")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top, 5)
                    
                    // Mostrar el resultado de la respuesta
                    if let result = answerResult {
                        Text(result)
                            .font(.title2)
                            .foregroundColor(result == "Correcto" ? .green : .red)
                            .padding(.top, 10)
                    }

                    // Botón para pasar a la siguiente pregunta
                    Button("Siguiente") {
                        if currentIndex < firstQuiz.text.count - 1 {
                            currentIndex += 1
                            answerResult = nil // Limpiar el resultado al pasar a la siguiente pregunta
                        } else {
                            print("Terminaste el quiz")
                        }
                    }
                    .padding(.top, 20)
                }
                .padding()
            } else {
                Text("No hay preguntas disponibles")
            }
        }
        .onAppear {
            Task {
                await quizVM.fetchAllQuizes()
            }
        }
        .navigationTitle("Quizzes")
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
    QuizListView()
}
