//
//  LoginView.swift
//  Board Game Center
//
//  Created by Michał Gorzkowski on 04/01/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Spacer()
            
            Text("Login")
                .font(.title)
                .padding()

            TextField("E-mail", text: $email)
                .padding()
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                // TODO: Firebase code for login here
            }) {
                Text("Log in")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()

            NavigationLink(
                destination: RegistrationView(),
                label: {
                    Text("Don't have an account? Register")
                        .foregroundColor(.blue)
                }
            )
            .padding()

        }
        .padding()
    }
}

#Preview {
    LoginView()
}
