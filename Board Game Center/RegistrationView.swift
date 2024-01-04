//
//  RegistrationView.swift
//  Board Game Center
//
//  Created by Michał Gorzkowski on 04/01/2024.
//

import SwiftUI

struct RegistrationView: View {
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
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm password", text: $confirmPassword)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                // TODO: Firebase code for registration here
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

            NavigationLink(
                destination: LoginView(),
                label: {
                    Text("Already have an account? Log in")
                        .foregroundColor(.blue)
                }
            )
            .padding()

        }
        .padding()
    }
}

#Preview {
    RegistrationView()
}
