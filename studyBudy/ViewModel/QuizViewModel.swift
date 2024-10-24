//
//  QuizViewModel.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import Foundation

@Observable
class QuizViewModel {
    var quizes : [Quiz] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    func fetchAllQuizes() async {
        isLoading = true
        errorMessage = nil

        let action = QuizRouter.GetAllQuizes()
        do {

            let response = try await ActionClient.dispatch(action)
            

            if response.isSuccess() {
                self.quizes = response.data ?? []
            } else {
                self.errorMessage = "Fallo en la carga de tarjetas"
            }
        } catch {

            self.errorMessage = "Error al obtener las tarjetas: \(error.localizedDescription)"
        }
        

        isLoading = false
    }
    
    
    func fetchQuizById(id: String) async -> Quiz? {
        isLoading = true
        errorMessage = nil

        let action = QuizRouter.GetQuiz(id: id)
        do {
            let response = try await ActionClient.dispatch(action)
            
            if response.isSuccess() {
                isLoading = false
                return response.data
            } else {
                self.errorMessage = "Error al cargar el quiz"
            }
        } catch {
            self.errorMessage = "Error al obtener el quiz: \(error.localizedDescription)"
        }
        
        isLoading = false
        return nil
    }
    
    // ir despegando las preguntas
    
    func getFormattedQuestions(for quiz: Quiz, at index: Int) -> String {
        guard index < quiz.text.count && index < quiz.answer.count else { return "No disponible" }
        let question = quiz.text[index]
        let answer = quiz.answer[index]
        return "\(question)"
    }
    
}
