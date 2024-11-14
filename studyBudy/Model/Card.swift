//
//  Card.swift
//  studyBudy
//

import Foundation

struct Card: Identifiable, Codable, Hashable {
    var id: String
    var creationDate: String
    var text: String

    
    enum CodingKeys: String, CodingKey {
        case id
        case creationDate = "creation_date"
        case text
    }
}
