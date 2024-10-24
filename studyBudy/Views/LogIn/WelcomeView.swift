import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct WelcomeView: View {
    let authentication = Authentication() // Instancia de la estructura de autenticación
    
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
                
                // Botón de Google con funcionalidad de login
                Button {
                    Task {
                        do {
                            try await authentication.googleOauth()
                            print("Inicio de sesión exitoso")
                        } catch {
                            print("Error al iniciar sesión: \(error.localizedDescription)")
                        }
                    }
                } label: {
                    HStack {
                      
                        Text("Google")
                            .font(.title3)
                            .fontWeight(.medium)
                            .frame(width: 327, height: 50) // Tamaño específico
                            .padding()
                            .background(Color.green) // Color de fondo verde
                            .cornerRadius(55) // Borde redondeado
                            .foregroundColor(.white) // Color del texto blanco
                    }
                }
                
                // Botón "Ingresar"
                Button(action: {
                    // Acción del botón Ingresar
                }) {
                    Text("Ingresar")
                        .font(.title3)
                        .fontWeight(.medium)
                        .frame(width: 327, height: 50) // Tamaño específico
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 55)
                                .stroke(Color.white, lineWidth: 2) // Borde blanco con grosor de 2
                        )
                        .foregroundColor(.white) // Color del texto blanco
                }
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
