//
//  SignInView.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 22/10/24.
//

import SwiftUI

struct SignInView: View {
    @State private var isActive = false
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    // Logo
                    Image("singIn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .shadow(radius: 10)
                        .padding(.bottom, 20)

                    // Titulo
                    Text("Bienvenido")
                        .font(.system(size: 45, weight: .bold))
                        .foregroundColor(Color(hex: "#21548D"))
                        .padding(.bottom, 10)

                    // Email
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Ingresa tu correo")
                            .font(.system(size: 20))
                            .foregroundColor(Color(hex: "#21548D"))
                            .bold()
                            .padding()
                        
                        TextField("Ingresa tu correo", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                            .frame(maxWidth: 500)
                    }
                    .padding(.horizontal)

                    // Contraseña
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Ingresa tu contraseña")
                            .font(.system(size: 20))
                            .foregroundColor(Color(hex: "#21548D"))
                            .bold()
                            .padding()
                        
                        
                        SecureField("Ingresa tu contraseña", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                            .frame(maxWidth: 500)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    // Sign Up Link
                    HStack {
                        Text("No tienes cuenta?")
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: "#21548D"))
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .font(.system(size: 18))
                                .bold()
                                .underline()
                                .foregroundColor(Color(hex: "#21548D"))
                        }
                    }
                    // Continue Button
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Continuar")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: 500)
                            .frame(height: 55)
                            .background(Color(hex: "#21548D"))
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                    .padding(.top, 20)

                    Spacer()
                }
                .navigationDestination(isPresented: $isActive) {
                    HomeView()
                        .navigationBarBackButtonHidden(true)
                }
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
