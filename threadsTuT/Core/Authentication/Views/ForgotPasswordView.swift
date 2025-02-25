//
//  ForgotPasswordView.swift
//  threadsTuT
//
//  Created by ABHINAV ANAND on 14/02/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            Spacer()
            
            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Enter your email to reset your password")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.horizontal)
                .padding(.top)
            
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Button(action: {
                if isValidEmail(email) {
                    // Perform password reset (e.g., make a network request)
                    print("Reset password email sent to \(email)")
                } else {
                    showError = true
                    errorMessage = "Please enter a valid email address."
                }
            }) {
                Text("Reset Password")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.top)
            
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }

    // Validation Function
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
