//
//  User.swift
//  studyBudy
//
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
    var creationDate: String
    var cards: [String]
    var quizes: [String]
    var score: Int

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case creationDate = "creation_date"
        case cards
        case quizes
        case score
    }
}

