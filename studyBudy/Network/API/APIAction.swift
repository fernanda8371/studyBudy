//
//  APIAction.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//

import Foundation

protocol APIAction : Action {
    var path: String { get }
    var request: URLRequest? { get }
}

extension APIAction {
    func makeBaseRequest() -> URLRequest? {
        let fullURL = API.baseURL + path
        guard let url = URL(string: fullURL) else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    func onDispatch() async throws -> ActionResponse<ResponseType> {
        guard let urlRequest = request else {
            return ActionResponse(status: .failedToDispatch)
        }
        
        print(urlRequest.url!)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            // If the response is invalid
            return ActionResponse(status: .unknownFailure)
        }
        
        guard (200...299).contains(response.statusCode) else {
            return ActionResponse(status: .actionFailed)
        }
        
        let decodedData = try JSONDecoder().decode(ResponseType.self, from: data)
        
        return ActionResponse(status: .success, data: decodedData)
    }
    
}
