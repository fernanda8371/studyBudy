//
//  Card.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import Foundation

struct Card: Identifiable, Codable, Hashable {
    var id: String
    // var cardOwner: String
    var creationDate: String
    var text: String

    
    enum CodingKeys: String, CodingKey {
        case id
        // case cardOwner = "card_owner"
        case creationDate = "creation_date"
        case text
    }
}
