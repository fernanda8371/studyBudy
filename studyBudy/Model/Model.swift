//
//  Model.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//

struct User : Codable {
    let id: Int
    let name: String
    let email: String
    let password: String
    let createdAt: String
    let updatedAt: String
}

struct Study : Codable {
    let id: Int
    let name: String
    let description: String
    let createdAt: String
    let updatedAt: String
}


