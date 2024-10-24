//
//  Quizes.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import Foundation

struct Quizes : Identifiable, Codable {
    var id: String
    var name: String
    var quizOwner: String
    var creationDate: String
    var text: [String]
    var answer: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case quizOwner = "quiz_owner"
        case creationDate = "creation_date"
        case text
        case answer
    }
}
