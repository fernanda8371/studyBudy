//
//  SignInView.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 22/10/24.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(Color(hex: "2AAFFA"))
                    .ignoresSafeArea()
                
                VStack{
                    Image("singIn")
                        .shadow(radius: 10)
                    
                    Text("Bienvenido")
                        .font(.system(size: 45))
                        .foregroundStyle(.white)
                        .padding()
                    
                    
                    // Email Text
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Ingresa tu correo")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        
                        TextField("Ingresa tu correo", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                            .frame(width: 550)
                    }
                    
                    // Password Text
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Ingresa tu contraseña")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        
                        SecureField("Ingresa tu contraseña", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                            .frame(width: 550)
                    }
                    .padding(.top, 10)
                    .padding()
                    
                    HStack{
                        Text("No tienes cuenta?")
                        
                        NavigationLink(destination: MainTabView()) {
                            Text("Sign Up")
                                .bold()
                                .underline()
                                .foregroundColor(.black)
                        }
                        
                    }
                  
                }
                .padding(.horizontal, 30)
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    SignInView()
}
