//
//  APIActionWithBody.swift
//  studyBudy
//
//  Created by José Ruiz on 23/10/24.
//

import Foundation

protocol APIActionWithBody : APIAction {
    associatedtype BodyType: Encodable
    
    var httpMethod: String { get }
    var body: BodyType { get }
}

extension APIActionWithBody {
    var request: URLRequest? {
        guard var request = makeBaseRequest() else {
            return nil
        }
        
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
            
            return request
        } catch {
            print("Could not convert body of request: \(error)")
            return nil
        }
    }
}
