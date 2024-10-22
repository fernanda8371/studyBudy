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
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading) // Alinea el texto a la izquierda
                
                Text("StudyMate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading) // Alinea el texto a la izquierda
            }
            .padding(.horizontal, 40) // Agrega padding horizontal para mejor visibilidad
            
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
                    backgroundColor: .blue,
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
       
        .edgesIgnoringSafeArea(.all) // Para que el fondo cubra toda la pantalla
    }
}

#Preview {
    WelcomeView()
}

