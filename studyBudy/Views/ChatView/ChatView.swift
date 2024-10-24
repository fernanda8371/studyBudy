import SwiftUI

// Placeholder color extension
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}

struct TypingIndicatorView: View {
    @State private var numberOfDots = 0
    
    var body: some View {
        HStack(spacing: 5) { // Espaciado entre las bolitas
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10) // Tamaño de las bolitas
                    .scaleEffect(numberOfDots == index ? 1.5 : 1.0) // Efecto de escala para animar
                    .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: numberOfDots)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                numberOfDots = (numberOfDots + 1) % 3 // Cambia el índice de la bolita animada
            }
        }
    }
}

struct ChatView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedTab: Int
    var isTabViewNavigation: Bool
    
    @ObservedObject var chatModel = ChatModel()
    @State private var isProEnabled: Bool = false // Toggle state
    @State private var showProInfo: Bool = false // Estado para mostrar el cuadro de información
    
    init(selectedTab: Binding<Int>, isTabViewNavigation: Bool) {
        self._selectedTab = selectedTab
        self.isTabViewNavigation = isTabViewNavigation
        let welcomeMessage = "Hola, soy Bufy. ¿En qué puedo ayudarte hoy?"
        chatModel.messages.append(ChatMessage(text: welcomeMessage, isUser: false))
        
        // Personalización de la barra de navegación
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Fondo blanco
            
            VStack {
                HStack {
                    Button(action: {
                        if isTabViewNavigation {
                            selectedTab = 0  // regresa a inicio
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")  // Back arrow
                                .foregroundColor(.black)
                            Image("lorenzoIcon")
                                .resizable()
                            .frame(width: 80, height: 80)
                            VStack{
                                
                                Text("Buddy AI")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.black)
                                Text("Ayúdate")
                                    
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .padding()
                    Spacer()
                    
                }
                BudyCardView()
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        ForEach(chatModel.messages) { message in
                            HStack {
                                if message.isUser {
                                    Spacer()
                                    Text(message.text)
                                        .padding()
                                        .background(Color.gray.opacity(0.3))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 1)
                                } else {
                                    HStack(alignment: .top) {
                                        Image("chatbot")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.black)
                                            .padding(.vertical)
                                        Text(message.text)
                                            .foregroundColor(.black)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .padding(.vertical, 5)
                                    Spacer()
                                }
                            }
                            .padding(message.isUser ? .leading : .trailing)
                            .id(message.id)
                        }
                        
                        if chatModel.isWaitingForResponse {
                            HStack {
                                TypingIndicatorView()
                                    .padding()
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                                Spacer()
                            }
                            .id("TypingIndicator")
                        }
                    }
                    
                    .padding()
                    .onChange(of: chatModel.messages.count) { _ in
                        scrollToBottom(scrollProxy: scrollProxy)
                    }
                    .onChange(of: chatModel.isWaitingForResponse) { _ in
                        scrollToBottom(scrollProxy: scrollProxy)
                    }
                }
                
                // Input box and Pro toggle
                VStack(spacing: 5) {
                    HStack {
                        // TextField
                        TextField("", text: $chatModel.inputText)
                            .placeholder(when: chatModel.inputText.isEmpty) {
                                Text("Escribe un mensaje...")
                                    .foregroundColor(.gray)
                            }
                            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 0))
                            .background(Color.white.opacity(0))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        // Send button
                        Button(action: {
                            if isProEnabled {
                                chatModel.sendProMessage()
                            } else {
                                chatModel.sendMessage()
                            }
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.black)
                                .padding(.trailing)
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 2))
                    
                    HStack {
                        Spacer()
                        
                        ZStack {
                            // Bufy-Pro toggle and info button
                            HStack(spacing: 10) {
                                Button(action: {
                                    showProInfo.toggle() // Toggle to show/hide info
                                }) {
                                    Image(systemName: "info.circle")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                }
                                
                                Spacer()
                                Image(systemName: "sparkles")
                                    .font(.system(size: 20))
                                    .foregroundColor(isProEnabled ? .blue : .gray)
                                    .scaleEffect(isProEnabled ? 1.2 : 1.0)
                                
                              
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                                    .labelsHidden()
                            }
                        }
                    }
                    .padding(.trailing, 15)
                    .padding(.vertical, 5)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity)
            }
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbarBackground(.clear, for: .tabBar)
            .toolbar(.hidden, for: .tabBar)
            
            // Floating info bubble (superposed and static in position)
            if showProInfo {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        BubbleView {
                            Text("**Bufy-Pro** es un modelo entrenado para dar respuestas del Código Civil de Nuevo León actualizado al 2024, como artículos y más. \n**Actívalo** si deseas consultas más específicas. *Redacta las preguntas de forma muy detallada.")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(8)
                        }
                        .frame(width: 300)
                        .offset(x: 0, y: -43) // Ajustado para estar justo arriba del ícono
                        Spacer().frame(width: 30)
                    }
                }
                .zIndex(1) // Asegura que esté en la capa superior
            }
        }
    }
    
    func scrollToBottom(scrollProxy: ScrollViewProxy) {
        withAnimation {
            if chatModel.isWaitingForResponse {
                scrollProxy.scrollTo("TypingIndicator", anchor: .bottom)
            } else if let lastMessageId = chatModel.messages.last?.id {
                scrollProxy.scrollTo(lastMessageId, anchor: .bottom)
            }
        }
    }
}

// Vista para la "burbuja" de información
struct BubbleView<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
            // La "flecha" de la burbuja
            Triangle()
                .fill(Color.black.opacity(0.7))
                .frame(width: 20, height: 10)
                .rotationEffect(.degrees(180))
        }
    }
}

// Forma de triángulo para la flecha
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct BudyCardView: View {
    var body: some View {
        HStack {
            // Imagen a la izquierda (puedes reemplazar con la imagen real)
            Image("lorenzoIcon")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.leading, 10)
            
            VStack(alignment: .leading) {
                Text("Buddy")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Text("Ayúdate de Buddy para resumir tu información, hacer preguntas y prepararte mejor!")
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(.top, 2)
            }
            .padding(.leading, 10)
            
            Spacer()
        }
        .padding()
        .background(Color(hex: "86CB8C"))
        .cornerRadius(20)
        .shadow(radius: 5)
        .frame(width: 334, height: 168)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(selectedTab: .constant(0), isTabViewNavigation: true)
    }
}

