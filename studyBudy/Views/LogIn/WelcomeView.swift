//
//  WelcomeView.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // Imagen principal alineada a la derecha
            HStack {
                Spacer() // Empuja la imagen hacia la derecha
                Image("budy_welcome")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 600) // Ajusta el ancho de la imagen según sea necesario
            }
            
            Spacer()
            
            // Texto de bienvenida alineado a la izquierda
            VStack(alignment: .leading, spacing: 8) {
                Text("Bienvenido a")
                    .font(.system(size: isIpad ? 40 : 24, weight: .regular)) // Tamaño adaptable
                    .foregroundColor(.white)
                
                Text("StudyMate")
                    .font(.system(size: isIpad ? 60 : 34, weight: .bold)) // Tamaño adaptable
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading) // Alinea el texto a la izquierda
            }
            .padding(.horizontal, isIpad ? 155 : 40) // Padding adaptable para iPad
            
            Spacer()
            
            // Botones usando el componente personalizado
            VStack(spacing: 16) {
                Boton(
                    title: "Google",
                    backgroundColor: .green,
                    textColor: .white,
                    action: {
                        // Acción del botón Google
                    }
                )
                
                Boton(
                    title: "Ingresar",
                    backgroundColor: Color(hex: "#2AAFFA"),
                    textColor: .white,
                    borderColor: .white,
                    action: {
                        // Acción del botón Ingresar
                    }
                )
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .background(Color(hex: "#2AAFFA"))
        .edgesIgnoringSafeArea(.all) // Para que el fondo cubra toda la pantalla
    }
    
    // Computed property to detect if the device is an iPad
    private var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}

#Preview {
    WelcomeView()
}
