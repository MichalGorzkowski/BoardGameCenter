//
//  AccountView.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 09/01/2024.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @ObservedObject var viewModel = AccountViewModel()
    @State var showingPasswordAlert = false
    
    let profileImage = ""

    var body: some View {
        VStack {
            Text("Imię: \(firebaseManager.user.firstName)")
                .padding()
            Text("Nazwisko: \(firebaseManager.user.lastName)")
                .padding()
            Text("E-mail: \(firebaseManager.user.email)")
                .padding()

            Spacer()

            Button(action: {
                firebaseManager.auth.sendPasswordReset(withEmail: "s22006@pjwstk.edu.pl") { error in
                    if let error = error {
                        print("DEBUG: Error while sending password reset: \(error)")
                        return
                    }
                }
                showingPasswordAlert = true
            }, label: {
                Text("Change password")
                    .foregroundColor(.blue)
                    .padding()
            })
            .alert("Email with a password reset link has been sent.", isPresented: $showingPasswordAlert) {
                Button("OK", role: .cancel) { }
            }
            
            Button(action: {
                firebaseManager.signOut()
            }, label: {
                Text("Sign out")
                    .foregroundColor(.red)
                    .padding()
            })
        }
        .onAppear {
            firebaseManager.getUserDataFromFirebase()
        }
    }
}

#Preview {
    AccountView()
}
