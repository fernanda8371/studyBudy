//
//  QuizRouter.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import Foundation

class QuizRouter {
    struct GetAllQuizes: APIGetAction {
        typealias ResponseType = [Quiz]
        var path = "/quizes"
    }
    
    struct GetQuiz: APIGetAction {
        typealias ResponseType = Quiz
        var path: String
        
        init(id: String) {
            self.path = "/quizes/\(id)" 
        }
    }
}
