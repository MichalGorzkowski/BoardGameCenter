//
//  RegistrationView.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 04/01/2024.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        VStack {
            Spacer()

            Text("Registration")
                .font(.title)
                .padding()

            TextField("E-mail", text: $email)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm password", text: $confirmPassword)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
                    return
                }
                
                authManager.signUp(email: email, password: password)
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()

            Button(action: {
                authManager.switchView()
            }) {
                Text("Already have an account? Log in")
            }
            .padding()

        }
        .padding()
    }
}

#Preview {
    RegistrationView()
}
