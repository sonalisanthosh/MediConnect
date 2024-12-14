//
//  ContentView.swift
//  MediConnect
//
//  Created by Sonali Santhosh on 10/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var emailOrPhone = ""
    @State private var password = ""
    
    var body: some View {
        VStack{
            Image("topper")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 150.0)
                
            Text("Welcome Back!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 50.0)
            
            // Email/Phone Input Field
            ZStack{
                Capsule()
                    .padding(0.0)
                    .frame(width: 350.0, height: 35.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                TextField("Enter Email or Phone Number", text: $emailOrPhone)
                    .padding(.horizontal, 35.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.083, green: 0.151, blue: 0.325)/*@END_MENU_TOKEN@*/)
                   
            }
            
            // Password Input Field
            ZStack{
                Capsule()
                    .padding(0.0)
                    .frame(width: 350.0, height: 35.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                SecureField("Enter Password", text: $password)
                    .padding(.horizontal, 35.0)
                    .foregroundColor(Color(red: 0.083, green: 0.151, blue: 0.325))
            }
            
            // Remember Me and Forgot Password
            HStack{
                Text("Remember me")
                    .padding(.leading, 30.0)
                
                Spacer()
                Text("Forgot Password?")
                    .padding(.trailing, 30.0)
            }
            .padding(.top, 3.0)
            .font(.footnote)
            .foregroundColor(Color.gray)
            
            
            // Login Button
            Button(action: {
                print("Email: \(emailOrPhone), Password: \(password)")
            }) {
                ZStack {
                    Capsule()
                        .frame(width: 350.0, height: 35.0)
                        .foregroundColor(Color(red: 0.083, green: 0.151, blue: 0.325))
                    Text("Log In")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                            }
                        }
            // Sign-Up Option
            Spacer()
            HStack{
                Text("Don't have an account?")
                    .foregroundColor(Color.gray)
                Text("Sign Up")
                    .foregroundColor(Color(hue: 0.62, saturation: 0.985, brightness: 0.925, opacity: 0.773))
                    .underline()
            }
            .padding(.bottom, 25.0)
            .font(.footnote)
        }
    }
}
        
        


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
