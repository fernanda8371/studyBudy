//
//  Action.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//

import Foundation

protocol Action {
    associatedtype ResponseType: Decodable
    func onDispatch() async throws -> ActionResponse<ResponseType>
}
