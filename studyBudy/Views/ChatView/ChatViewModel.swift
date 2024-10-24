import SwiftUI
import Combine

// Modelo para un solo mensaje en el chat
struct ChatMessage: Identifiable {
    let id = UUID() // Identificador único
    let text: String // Texto del mensaje
    let isUser: Bool // Booleano para saber si es un mensaje del usuario o del bot
}

// Modelo observable para manejar la lógica del chat
class ChatModel: ObservableObject {
    // Array de mensajes del chat
    @Published var messages: [ChatMessage] = []
    
    // Texto actual en el campo de entrada
    @Published var inputText: String = ""
    
    // Indicador para saber si se está esperando respuesta
    @Published var isWaitingForResponse: Bool = false
    
    // Función para enviar el mensaje del usuario
    func sendMessage() {
        guard !inputText.isEmpty else { return }
        
        // Añadir el mensaje del usuario
        let userMessage = ChatMessage(text: inputText, isUser: true)
        messages.append(userMessage)
        
        // Limpiar el campo de entrada
        inputText = ""
        
        // Simular una respuesta del bot
        receiveBotMessage()
    }
    
    // Función para enviar un mensaje Pro (si está activado)
    func sendProMessage() {
        guard !inputText.isEmpty else { return }
        
        // Añadir el mensaje del usuario
        let userMessage = ChatMessage(text: "[Pro] \(inputText)", isUser: true)
        messages.append(userMessage)
        
        // Limpiar el campo de entrada
        inputText = ""
        
        // Simular una respuesta Pro del bot
        receiveBotMessage(pro: true)
    }
    
    // Simular la respuesta del bot
    private func receiveBotMessage(pro: Bool = false) {
        isWaitingForResponse = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let botMessageText = pro ? "Este es un mensaje Pro del bot." : "Este es un mensaje del bot."
            let botMessage = ChatMessage(text: botMessageText, isUser: false)
            
            // Añadir la respuesta del bot
            self.messages.append(botMessage)
            self.isWaitingForResponse = false
        }
    }
}

