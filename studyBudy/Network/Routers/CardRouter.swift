//
//  CardRouter.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import Foundation

class CardRouter {
    struct GetAllCards : APIGetAction {
        typealias ResponseType = [Card]
        var path = "cards"
    }
    
    struct GetCards : APIGetAction {
        typealias ResponseType = [Card]
        var path: String
        
        init(path: String) {
            self.path = path
        }
    }
}
