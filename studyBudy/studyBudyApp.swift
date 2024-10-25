//
//  studyBudyApp.swift
//  studyBudy
//
//  Created by Geidy Vásquez on 22/10/24.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct studyBudyApp: App {
    
    @State var loginModel = LoginModel()
    @AppStorage("log_status") var logStatus: Bool = false // Manejo del estado de inicio de sesión
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            if logStatus {
                MainTabView()
                    .environment(loginModel)
            } else {
                WelcomeView()
                    .environment(loginModel)// Mostrar WelcomeView si el usuario no está autenticado
            }
        }
    }
}

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        if let clientID = FirebaseApp.app()?.options.clientID{
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
        }
        return true
    }
}
