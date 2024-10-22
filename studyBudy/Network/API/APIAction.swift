//
//  APIAction.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//

import Foundation

protocol APIAction : Action {
    var path: String { get }
    var REQUEST: URLRequest? { get }
}

extension APIAction {
    
    
}
