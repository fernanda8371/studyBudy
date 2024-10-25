//
//  FlashCardVM.swift
//  studyBudy
//
//  Created by José Ruiz on 24/10/24.
//

import Foundation

@Observable
class CardViewModel {
    var cards: [Card] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    
    // Add flashcard
    func addFlashCard(newText: String) {
        
        let newCard = Card(
            id: UUID().uuidString, // generate id and other values
            cardOwner: "OwnerName",
            creationDate: Date().description, 
            text: newText
        )
        cards.append(newCard)
        saveCardToStorage(card: newCard)
    }
    
    private func saveCardToStorage(card: Card) {
        // Aquí puedes implementar la lógica para guardar la tarjeta
        // en un almacenamiento persistente (CoreData, UserDefaults, Firebase, etc.)
        // Por ejemplo:
        print("Tarjeta guardada: \(card.text)")
    }


    func fetchAllCards() async {
        isLoading = true
        errorMessage = nil

        let action = CardRouter.GetAllCards()
        do {

            let response = try await ActionClient.dispatch(action)
            

            if response.isSuccess() {
                self.cards = response.data ?? []
            } else {
                self.errorMessage = "Fallo en la carga de tarjetas"
            }
        } catch {

            self.errorMessage = "Error al obtener las tarjetas: \(error.localizedDescription)"
        }
        

        isLoading = false
    }
}
