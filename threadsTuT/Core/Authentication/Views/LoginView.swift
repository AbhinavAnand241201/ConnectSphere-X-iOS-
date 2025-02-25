//
//  LoginView.swift
//  threadsTuT
//
//  Created by ABHINAV ANAND on 14/02/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Threads Icon
                Image("threads_icon") // Make sure to add this image in your Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                    // Email Field
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.horizontal)
                    
                    // Password Field
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding(.horizontal)
                }
                
                HStack {
                    Spacer()
                    NavigationLink("Forgot Password?", destination: ForgotPasswordView())
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .padding(.trailing)
                }
                
                Spacer()
                
                Button(action: {
                    if isValidEmail(email) && isValidPassword(password) {
                        // Perform login (e.g., make a network request)
                        print("Login successful")
                    } else {
                        showError = true
                        errorMessage = "Invalid email or password."
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Divider()
                    .padding(.vertical)
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink("Sign Up", destination: SignUpView())
                       
//                    navigationbarbackbuttonhidden implementation is yet to be done so that the back button by default doesnt show up in the signup page ....
                        .foregroundColor(.blue)
                }
                .font(.footnote)
                
                Spacer()
            }
            .background(Color.white.ignoresSafeArea())
        }
    }

    // Validation Functions
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
