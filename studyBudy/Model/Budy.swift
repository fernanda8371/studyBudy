//
//  Aprendizaje.swift
//  studyBudy
//
//  Created by José Ruiz on 23/10/24.
//

import Foundation

// Modelo para un solo mensaje en el chat
struct ChatMessage: Identifiable {
    let id = UUID() // Identificador único
    let text: String // Texto del mensaje
    let isUser: Bool // Booleano para saber si es un mensaje del usuario o del bot
}
