//
//  ActionResponse.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//

import Foundation


enum Status {
    case success
    case actionFailed
    case failedToDispatch
    case unknownFailure
}

class ActionResponse<T> {
    var status: Status
    var data: T?
    
    func isSuccess() -> Bool {
        return status == .success
    }
    
    init(status: Status, data: T? = nil) {
        self.status = status
        self.data = data
    }
}
