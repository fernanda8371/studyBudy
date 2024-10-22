//
//  ActionClient.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//

import Foundation

class ActionClient {
    
    static func dispatch<A: Action>(_ action: A) async throws -> ActionResponse<A.ResponseType> {
        return try await action.onDispatch()
    }
    
}
