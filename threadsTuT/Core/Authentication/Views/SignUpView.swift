import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var fullName: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            Spacer()
            
            // Threads Icon
            Image("threads_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 16) {
                // Full Name Field
                TextField("Full Name", text: $fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.horizontal)
                
                // Username Field
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.horizontal)
                
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
            
            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Spacer()
            
            Button(action: {
                if isValidEmail(email) && isValidPassword(password) && !fullName.isEmpty && !username.isEmpty {
                    // Perform sign-up (e.g., make a network request)
                    print("Sign-up successful for \(email)")
                } else {
                    showError = true
                    errorMessage = "Please fill all fields correctly."
                }
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Divider()
                .padding(.vertical)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Already have an account? Login")
                    .foregroundColor(.blue)
            }
            .font(.footnote)
            
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true) // Hide the back button
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
