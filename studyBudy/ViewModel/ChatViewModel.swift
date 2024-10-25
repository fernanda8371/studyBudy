import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import SwiftUI

class ChatModel: ObservableObject {
	@Published var messages: [ChatMessage] = []
	@Published var inputText: String = ""
	@Published var isWaitingForResponse: Bool = false
	@Published var selectedImage: UIImage? = nil
	@AppStorage("mongo_user_id") var mongoUserID: String = ""

	// Método para enviar el mensaje y la imagen al servidor
	func uploadImage(image: UIImage) {
		self.selectedImage = image
		guard let selectedImage = selectedImage else {
			return
		}
		
		isWaitingForResponse = true
		guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
			print("Error al convertir la imagen a datos JPEG")
			return
		}

		// *Harcodear el user_id aquí*
		let hardcodedUserId = "671840962a2c8c5b4ee95a57"  // Reemplaza con tu user_id

		let boundary = UUID().uuidString
		let urlString = "https://api-sb-rust.vercel.app/chatbot/upload"
		guard let url = URL(string: urlString) else { return }
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
		
		// Crear el cuerpo de la solicitud con la imagen y el user_id
		let body = createMultipartFormData(imageData: imageData, boundary: boundary, userId: hardcodedUserId)
		request.httpBody = body

		// Enviar la solicitud al servidor
		URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
			DispatchQueue.main.async {
				self?.isWaitingForResponse = false
			}

			if let error = error {
				print("Error en la solicitud: \(error.localizedDescription)")
				return
			}

			guard let data = data else {
				print("No se recibieron datos de la respuesta.")
				return
			}

			// Imprime los datos crudos para depuración
			if let responseString = String(data: data, encoding: .utf8) {
				print("Respuesta del servidor: \(responseString)")
			}

			// Luego intenta analizar la respuesta JSON
			if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
			   let quizId = jsonResponse["quiz_id"] as? String {
				DispatchQueue.main.async {
					self?.messages.append(ChatMessage(text: "Imagen subida exitosamente. Quiz ID: \(quizId)", isUser: false))
				}
			} else {
				print("Error en el análisis de la respuesta JSON.")
				DispatchQueue.main.async {
					self?.messages.append(ChatMessage(text: "Error en la subida de la imagen.", isUser: false))
				}
			}
		}.resume()
	}

	private func createMultipartFormData(imageData: Data, boundary: String, userId: String) -> Data {
		var body = Data()

		let boundaryPrefix = "--\(boundary)\r\n"

		// *Enviar el user_id como parte del cuerpo*
		body.appendString(boundaryPrefix)
		body.appendString("Content-Disposition: form-data; name=\"user_id\"\r\n\r\n")
		body.appendString("\(userId)\r\n")  // Aquí el user_id hardcodeado

		// *Adjuntar la imagen al cuerpo de la solicitud*
		body.appendString(boundaryPrefix)
		body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n")
		body.appendString("Content-Type: image/jpeg\r\n\r\n")
		body.append(imageData)
		body.appendString("\r\n")

		// Finalizar el cuerpo de la solicitud
		body.appendString("--\(boundary)--\r\n")

		return body
	}

	func sendMessage() {
		isWaitingForResponse = true
		sendRequest(to: "https://api-sb-rust.vercel.app/chatbot/predict")
	}

	func sendProMessage() {
		isWaitingForResponse = true
		sendRequest(to: "https://api-sb-rust.vercel.app/chatbot/predict")
	}

	private func sendRequest(to urlString: String) {
		let userMessage = inputText
		messages.append(ChatMessage(text: userMessage, isUser: true))
		inputText = ""

		guard let url = URL(string: urlString) else { return }

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")

		let parameters = ["prompt": userMessage, "_id": mongoUserID]

		request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

		URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
			DispatchQueue.main.async {
				self?.isWaitingForResponse = false // Ocultar indicador de espera
			}
			if let data = data,
			   let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: String],
			   let aiResponse = jsonResponse["response"] {
				DispatchQueue.main.async {
					self?.messages.append(ChatMessage(text: aiResponse, isUser: false))
				}
			} else {
				let errorMessage = error?.localizedDescription ?? "Unknown error"
	DispatchQueue.main.async {
		self?.messages.append(ChatMessage(text: "Error: \(errorMessage)", isUser: false))
	}
}

		}.resume()
	}
}

// Extensión para agregar cadenas a Data
extension Data {
	mutating func appendString(_ string: String) {
		if let data = string.data(using: .utf8) {
			append(data)
		}
	}
}
