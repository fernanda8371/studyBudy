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
