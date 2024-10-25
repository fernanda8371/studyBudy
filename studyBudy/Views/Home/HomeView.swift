import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Charts

struct HomeView: View {
    @AppStorage("mongo_user_name") var mongoUserName: String = "" // Nombre del usuario guardado
    @AppStorage("mongo_user_email") var mongoUserEmail: String = "" // Email del usuario
    @AppStorage("log_status") var logStatus: Bool = false // Estado de inicio de sesión

    //@StateObject private var examViewModel = ExamProgressViewModel()
    
    @State private var selectedChart: ChartType?
    
    enum ChartType: Identifiable {
        case progressView
        
        var id: Int {
            hashValue
        }
    }
        
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
     
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                // Header con saludo y datos de usuario desde AppStorage
                
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.yellow)
                    
                    VStack(alignment: .leading) {
                        // Mostrar el nombre del usuario autenticado
                        Text("Hola \(mongoUserName)") // Usando el valor de AppStorage
                            .font(.title3)
                            .bold()
                        
                        Text("¿Cómo quieres empezar a estudiar?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                }
                .padding(.top)
                .padding(.horizontal)
                
                // Sesión de estudio
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 0.67, green: 0.84, blue: 0.99))
                    .frame(width: geometry.size.width * (UIDevice.current.userInterfaceIdiom == .pad ? 0.95 : 0.9), height: geometry.size.height * 0.25) // Adaptable a iPhone y iPad
                    .overlay(
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Sesión de estudio")
                                    .font(.title3)
                                    .foregroundColor(.black)
                                Text("¿Cómo vas a estudiar hoy?")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                            Image("homeBudy") // Imagen HomeBudy añadida
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.25) // Tamaño adaptado
                        }
                        .padding(.horizontal)
                    )
                    .padding(.top)

                    .padding(.horizontal)
                
                // Sección de técnicas de estudio
                Text("Técnicas de estudio")
                    .font(.title3)
                    .padding(.top)

                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        NavigationLink(destination: PomodoroView()) {
                            StudyTechniqueView(imageName: "timer", title: "Pomodoro", action: "Empezar")
                        }

                        StudyTechniqueView(imageName: "book", title: "Método Cornell", action: "Empezar")

                        NavigationLink(destination: FlashCards()) {
                            StudyTechniqueView(imageName: "brain.head.profile", title: "Active recall", action: "Empezar")
                        }

                        StudyTechniqueView(imageName: "pencil", title: "Edición", action: "Empezar")
                    }
                    .padding(.top)

                    .padding(.horizontal, 3)
                }
                
                ExamProgressPieChartView()
                    .frame(height: 200)
                    .frame(width: 800, alignment: .leading) // Alineación a la izquierda
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.2)) // Color personalizado
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .foregroundColor(.black) // Cambié el color del texto a negro para mayor legibilidad
                    .padding(.top)

                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading) // Asegura que el contenido esté alineado a la izquierda

                // Progreso de perfil
//                RoundedRectangle(cornerRadius: 15)
//                    .fill(Color.green)
//                    .frame(height: geometry.size.height * 0.15) // Tamaño adaptado
//                    .overlay(
//                        Text("Progreso de perfil")
//                            .font(.headline)
//                            .foregroundColor(.black)
//                            .padding(.leading, 16),
//                        alignment: .leading
//                    )
//                    .padding(.horizontal)
                
                Spacer()
                
                // Botón para cerrar sesión
                Button(action: {
                    signOut() // Cerrar sesión
                }) {
                    HStack {
                        Spacer()
                        Text("Cerrar sesión")
                            .foregroundColor(.red)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }
                
                .padding()

                
                // Barra de navegación (simulada para esta vista)
                HStack {
                    TabBarButton(imageName: "house.fill", title: "Inicio")
                    TabBarButton(imageName: "chart.bar.fill", title: "Progreso")
                    TabBarButton(imageName: "person.2.fill", title: "Budy AI")
                    TabBarButton(imageName: "book.fill", title: "Aprendizaje", notificationCount: 2)
                    TabBarButton(imageName: "person.fill", title: "Perfil")
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
    }
    func signOut() {
        logStatus = false
        mongoUserName = ""
        mongoUserEmail = ""
        
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            print("Sesión cerrada correctamente")
        } catch {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }
}

// Vista para las técnicas de estudio
struct StudyTechniqueView: View {
    let imageName: String
    let title: String
    let action: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 60, height: 60) // Círculo más grande
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30) // Ícono más pequeño
                    .foregroundColor(.black) // Color del ícono
            }
            
            Text(title)
                .font(.subheadline)
            
            Text(action)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .frame(width: 100)
    }
}

// Vista para los botones de la barra de navegación
struct TabBarButton: View {
    let imageName: String
    let title: String
    var notificationCount: Int? = nil
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: imageName)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                if let count = notificationCount {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 16, height: 16)
                        .overlay(
                            Text("\(count)")
                                .foregroundColor(.white)
                                .font(.footnote)
                        )
                        .offset(x: 10, y: -10)
                }
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .previewDevice("iPhone 14")
            HomeView()
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
        }
    }
}
