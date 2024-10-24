//
//  APIGetAction.swift
//  studyBudy
//
//  Created by José Ruiz on 23/10/24.
//

import Foundation


protocol APIGetAction: APIAction {}

extension APIGetAction {
    var request: URLRequest? {
        guard let baseRequest = makeBaseRequest() else {
            return nil
        }
        
        return baseRequest
    }
}
