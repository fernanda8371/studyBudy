//
//  SignUpView.swift
//  studyBudy
//
//  Created by Maria Castresana on 22/10/24.
//

import SwiftUI

struct RegistroView: View {
    @State private var nombre: String = ""
    @State private var correo: String = ""
    @State private var contraseña: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Bienvenido")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color(hex: "#21548D"))
                .padding(.bottom, 20)
            
            Text("Por favor, ayúdanos a continuar con tu registro llenando tus datos.")
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
                .padding(.bottom, 20)
            
            VStack(spacing: 20) {
                // Campo de Nombre
                VStack(alignment: .leading, spacing: 5) {
                    Text("Nombre")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                    
                    TextField("Nombre", text: $nombre)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 60)
                
                // Campo de Correo
                VStack(alignment: .leading, spacing: 5) {
                    Text("Correo")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)

                    TextField("Correo", text: $correo)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 60)
                
                // Campo de Contraseña
                VStack(alignment: .leading, spacing: 5) {
                    Text("Contraseña")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)

                    SecureField("Contraseña", text: $contraseña)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 60)
            }
            .padding(.bottom, 40)
            
            Button(action: {
                // Acción al presionar el botón
            }) {
                Text("Continuar")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#21548D"))
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
            }
            .padding(.bottom, 40)
            
            Spacer()
        }
        .background(Color(hex: "#2AAFFA")) // Color de fondo personalizado
        .edgesIgnoringSafeArea(.all)
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

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView()
    }
}

