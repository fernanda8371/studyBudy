import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

@Observable
class LoginModel {
    
    var user: User = User(id: "", name: "", email: "", creationDate: "", cards: [], quizes: [], score: 0)
    var showError: Bool = false
    var errorMessage: String = ""
    
    let urlPrefix = "https://api-sb-rust.vercel.app/"
    
    @AppStorage("log_status") @ObservationIgnored var logStatus: Bool = false
    @AppStorage("mongo_user_name") @ObservationIgnored var mongoUserName: String = ""
    @AppStorage("user_email") @ObservationIgnored var userEmail: String = ""
    @AppStorage("mongo_user_id") @ObservationIgnored var mongoUserID: String = ""
    @AppStorage("mongo_user_createdAt") @ObservationIgnored var mongoUserCreatedAt: String = ""
    
    func handleError(error: Error) async {
        await MainActor.run {
            errorMessage = error.localizedDescription
            showError.toggle()
        }
    }
    
    func logGoogleUser(user: GIDGoogleUser) async {
        Task {
            do {
                guard let idToken = user.idToken else { return }
                let accessToken = user.accessToken
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                
                try await Auth.auth().signIn(with: credential)
                
                print("Success Google!")
                userEmail = user.profile?.email ?? ""
                await fetchUser()  // Fetch MongoDB user data
                await MainActor.run {
                    withAnimation(.easeInOut) {
                        logStatus = true
                    }
                }
            } catch {
                await handleError(error: error)
            }
        }
    }
    
    // Function to create a new user in the backend
    func createUser(user: GIDGoogleUser, roleType: String) async {
        let url = URL(string: "\(urlPrefix)add-user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newUser: [String: Any] = [
            "name": user.profile?.name ?? "",
            "email": user.profile?.email ?? "",
            "score": 0,
            "cards": [],
            "quizes": []
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: newUser, options: [])
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                print("User Created Google!")
                userEmail = user.profile?.email ?? ""
                await fetchUser()
                await MainActor.run {
                    withAnimation(.easeInOut) {
                        logStatus = true
                    }
                }
            } else {
                print("Failed to create user: HTTP \(response)")
            }
        } catch {
            print("Failed to create user: \(error.localizedDescription)")
        }
    }
    
    // Function to fetch user from MongoDB by email
    func fetchUser() async {
        let url = URL(string: "\(urlPrefix)users/email/\(userEmail)")!
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        do {
            print("Email: \(userEmail)")
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
            
            if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
                user = decodedResponse
                mongoUserID = user.id
                mongoUserName = user.name
                mongoUserCreatedAt = user.creationDate
            } else {
                print("User not found")
            }
        } catch {
            print("Invalid data")
        }
    }
}

extension UIApplication {
    func rootController() -> UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else { return .init() }
        guard let viewController = window.windows.last?.rootViewController else { return .init() }
        
        return viewController
    }
}
