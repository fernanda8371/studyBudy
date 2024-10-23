//
//  studyBudyApp.swift
//  studyBudy
//
//  Created by Geidy Vásquez on 22/10/24.
//

import Foundation
import SwiftUI
import SwiftData
import Firebase
import GoogleSignIn

@main
struct studyBudyApp: App {
    init() {
            // Firebase initialization
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
