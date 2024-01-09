//
//  AuthManager.swift
//  Board Game Center
//
//  Created by Michał Gorzkowski on 04/01/2024.
//

import Firebase

class AuthManager: ObservableObject {
    let auth = Auth.auth()
    
    @Published var loggedIn = false
    @Published var isRegistrationViewActive = false
    
    var isLoggedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.loggedIn = true
            }
            
            print("DEBUG: user signed in successfully")
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email,
                        password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.loggedIn = true
            }
            
            print("DEBUG: user signed up successfully")
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.loggedIn = false
        
        print("DEBUG: user signed out successfully")
    }
    
    func switchView() {
        DispatchQueue.main.async {
            self.isRegistrationViewActive = !self.isRegistrationViewActive
            print("DEBUG: isRegistrationViewActive: ", self.isRegistrationViewActive)
        }
    }
}
