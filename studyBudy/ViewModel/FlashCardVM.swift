//  FlashCardVM.swift
//  studyBudy
//
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
        
        let baseURL = "https://api-sb-rust.vercel.app/cards" // Change to remote URL if needed
        
        guard let url = URL(string: baseURL) else {  // Fixed variable name here
            self.errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
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
