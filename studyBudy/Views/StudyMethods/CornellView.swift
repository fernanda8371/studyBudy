import SwiftUI

struct CornellView: View {
    @State private var singleSelection: UUID?

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Método Cornell")
                    .font(.system(size: 30, weight: .bold)) // Tamaño y estilo de fuente
                    .foregroundColor(Color(hex: "#21548D")) // Color azul personalizado
                    .padding(.top, 20) // Espacio en la parte superior
                    .padding(.bottom, 10) // Espacio en la parte inferior
                    .multilineTextAlignment(.center) // Alineación centrada

               
                SubjectListView() // Componente de lista de materias


                Spacer()

                Button(action: {
                    // Acción para nueva nota
                }) {
                    Text("Nueva Nota")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#21548D"))
                        .cornerRadius(30)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20) // Espacio en la parte inferior
                }
            }
            .navigationBarTitleDisplayMode(.inline) // Centra el título en la barra de navegación si es necesario
            .toolbar {
                ToolbarItem(placement: .principal) {
                    EmptyView() // No es necesario un título en la barra de navegación
                }
            }
        }
    }
}


struct CornellView_Previews: PreviewProvider {
    static var previews: some View {
        CornellView()
    }
}

