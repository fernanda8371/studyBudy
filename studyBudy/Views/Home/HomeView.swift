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
    @State private var showAlert = false
    
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
            ZStack {
                ScrollView {
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
                            
                            Button(action: {
                                showAlert = true
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 55, height: 55)
                                    
                                    
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            
                        }
                        .padding(.top)
                        .padding(.horizontal)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Log Out"),
                                message: Text("Are you sure you want to log out?"),
                                primaryButton: .destructive(Text("Log Out")) {
                                    signOut() // Lógica de cierre de sesión
                                },
                                secondaryButton: .cancel()
                            )
                        }
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
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                NavigationLink(destination: PomodoroView()) {
                                    StudyTechniqueView(imageName: "timer", title: "Pomodoro", action: "Empezar")
                                }
                                
                                NavigationLink(destination: QuizView()) {
                                    StudyTechniqueView(imageName: "book", title: "Quiz", action: "Empezar")
                                }
                                
                                NavigationLink(destination: FlashCards()) {
                                    StudyTechniqueView(imageName: "brain.head.profile", title: "Active recall", action: "Empezar")
                                }
                                NavigationLink(destination: FlashCards()) {
                                    StudyTechniqueView(imageName: "figure.cooldown", title: "Cornell", action: "Empezar")
                                }
                                NavigationLink(destination: FlashCards()) {
                                    StudyTechniqueView(imageName: "tortoise.circle", title: "Active recall", action: "Empezar")
                                }
                                NavigationLink(destination: FlashCards()) {
                                    StudyTechniqueView(imageName: "hand.point.up.braille", title: "Active recall", action: "Empezar")
                                }
                                
                            }
                            .padding(.top)
                            .padding(.horizontal)
                        }
                        
                        HStack{
                            
                            PomodoroMetric(completedPomodoros: 4, totalPomodoros: 5)
                            ExamProgressPieChartView()
                            
                        }.padding()
                            .frame(width: geometry.size.width * (UIDevice.current.userInterfaceIdiom == .pad ? 0.95 : 0.9), height: 200)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.blue.opacity(0.2)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                            )
                            .padding(.horizontal)
                            .padding(.top, 40)
                    }
                }
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

