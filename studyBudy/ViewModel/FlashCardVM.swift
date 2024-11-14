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
    
    // Fetch all cards from the API
    func fetchAllCards() async {
        isLoading = true
        errorMessage = nil
        
        let baseURL2 = "http://localhost:3000/api/cards" // Change to remote URL if needed
        
        guard let url2 = URL(string: baseURL2) else {  // Fixed variable name here
            self.errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url2)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check if the response is valid (HTTP status code 200)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.errorMessage = "Failed to load cards"
                isLoading = false
                return
            }
            
            // Parse the response data into the card model
            let decoder = JSONDecoder()
            let decodedCards = try decoder.decode([Card].self, from: data)
            
            // Update the cards array
            self.cards = decodedCards
        } catch {
            self.errorMessage = "Error fetching cards: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
