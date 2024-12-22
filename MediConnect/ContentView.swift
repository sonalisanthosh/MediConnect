//
//  ContentView.swift
//  MediConnect
//
//  Created by Sonali Santhosh on 10/30/24.
//

import SwiftUI

// Models for network requests
struct LoginRequest: Codable {
    let email_or_phone: String
    let password: String
}

struct LoginResponse: Codable {
    let message: String
    let token: String
}

struct RegisterRequest: Codable {
    let email: String
    let phone: String?
    let password: String
}

// View Model to handle authentication logic
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func login(emailOrPhone: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        let loginData = LoginRequest(email_or_phone: emailOrPhone, password: password)
        
        guard let url = URL(string: "http://localhost:8000/login") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(loginData)
        } catch {
            errorMessage = "Error encoding data"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    // Store token securely (you should use Keychain in production)
                    UserDefaults.standard.set(response.token, forKey: "authToken")
                    self?.isAuthenticated = true
                } catch {
                    self?.errorMessage = "Invalid response from server"
                }
            }
        }.resume()
    }
}

struct ContentView: View {
    @State private var emailOrPhone = ""
    @State private var password = ""
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            Image("topper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 150.0)
            
            Text("Welcome Back!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 50.0)
            
            // Email/Phone Input Field
            ZStack {
                Capsule()
                    .padding(0.0)
                    .frame(width: 350.0, height: 35.0)
                    .foregroundColor(.white)
                    .border(Color.black, width: 2)
                    .cornerRadius(20.0)
                TextField("Enter Email or Phone Number", text: $emailOrPhone)
                    .padding(.horizontal, 35.0)
                    .foregroundColor(Color(red: 0.083, green: 0.151, blue: 0.325))
            }
            
            // Password Input Field
            ZStack {
                Capsule()
                    .padding(0.0)
                    .frame(width: 350.0, height: 35.0)
                    .foregroundColor(.white)
                    .border(Color.black, width: 2)
                    .cornerRadius(20.0)
                SecureField("Enter Password", text: $password)
                    .padding(.horizontal, 35.0)
                    .foregroundColor(Color(red: 0.083, green: 0.151, blue: 0.325))
            }
            
            // Remember Me and Forgot Password
            HStack {
                Text("Remember me")
                    .padding(.leading, 30.0)
                
                Spacer()
                Text("Forgot Password?")
                    .padding(.trailing, 30.0)
            }
            .padding(.top, 3.0)
            .font(.footnote)
            .foregroundColor(Color.gray)
            
            // Error Message
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.top, 5)
            }
            
            // Login Button
            Button(action: {
                authViewModel.login(emailOrPhone: emailOrPhone, password: password)
            }) {
                ZStack {
                    Capsule()
                        .frame(width: 350.0, height: 35.0)
                        .foregroundColor(Color(red: 0.083, green: 0.151, blue: 0.325))
                    if authViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Log In")
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    }
                }
            }
            .disabled(authViewModel.isLoading)
            
            // Sign-Up Option
            Spacer()
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(Color.gray)
                Text("Sign Up")
                    .foregroundColor(Color(hue: 0.62, saturation: 0.985, brightness: 0.925, opacity: 0.773))
                    .underline()
            }
            .padding(.bottom, 25.0)
            .font(.footnote)
        }
        .onChange(of: authViewModel.isAuthenticated) { isAuthenticated in
            if isAuthenticated {
                // Navigate to the main app view
                // We'll need to implement this navigation
                print("Successfully logged in!")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
