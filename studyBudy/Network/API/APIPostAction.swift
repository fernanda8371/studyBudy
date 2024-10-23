//
//  APIPostAction.swift
//  studyBudy
//
//  Created by José Ruiz on 23/10/24.
//

import Foundation

protocol APIPostAction : APIActionWithBody {}

extension APIPostAction {
    var httpMethod: String { "POST" }
}
