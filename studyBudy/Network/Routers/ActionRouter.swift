//
//  ActionRouter.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//

import Foundation

struct TestUser : Identifiable, Codable {
    var firstName: String
    var lastName: String
    var id: Int
}

struct TestResponse: Codable {
    var users: [TestUser]
}

class ActionRouter {
    
    
    
}
