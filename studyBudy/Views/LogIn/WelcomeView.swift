import SwiftUI
import GoogleSignIn
import FirebaseAuth


struct WelcomeView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("mongo_user_email") var userEmail: String = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(LoginModel.self) var loginModel
    
    let authentication = Authentication()
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Image("budy_welcome")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 600)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Bienvenido a")
                    .font(.system(size: isIpad ? 40 : 24, weight: .regular))
                    .foregroundColor(.white)
                
                Text("StudyBuddy")
                    .font(.system(size: isIpad ? 60 : 34, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, isIpad ? 155 : 40)
            
            Spacer()
            
            VStack(spacing: 16) {
                Button{
                    Task{
                        do {
                            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController())
                            await loginModel.logGoogleUser(user: result.user)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    HStack {
                        Text("Ingresa con Google")
                            .font(.title3)
                            .fontWeight(.medium)
                            .frame(width: 327, height: 50)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(55)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .background(Color(hex: "#2AAFFA"))
        .edgesIgnoringSafeArea(.all)
    }
    
    private var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}


#Preview {
    WelcomeView()
}
