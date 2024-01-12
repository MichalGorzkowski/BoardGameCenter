//
//  FirebaseManager.swift
//  Board Game Center
//
//  Created by Michał Gorzkowski on 04/01/2024.
//

import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class FirebaseManager: ObservableObject {
    let auth = Auth.auth()
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
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
            
            print("DEBUG: user \(String(describing: self?.auth.currentUser?.uid)) signed in successfully")
        }
    }
    
    func signUp(firstName: String, lastName: String, email: String, password: String, image: UIImage?) {
        auth.createUser(withEmail: email,
                        password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.loggedIn = true
            }
            
            print("DEBUG: user \(String(describing: self?.auth.currentUser?.uid)) signed up successfully")
            
            self?.saveProfileInfoInFirebase(firstName: firstName, lastName: lastName, email: email, image: image ?? UIImage(resource: .minifigure))
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
    
    private func saveProfileInfoInFirebase(firstName: String, lastName: String, email: String, image: UIImage) {
        guard let uid = auth.currentUser?.uid else { return }
        let ref = storage.reference().child("profileImages/\(uid)")
        var photoUrl: String = ""
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Failed to push image to storage: \(error)")
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    print("DEBUG: Failed to retrieve downloadURL: \(error)")
                    return
                }
                
                photoUrl = url?.absoluteString ?? ""
                
                print("DEBUG: image stored successfully with url: \(url?.absoluteString ?? "")")
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
            self.db.collection("users").document(uid).setData([
                "uid": uid,
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "photoURL": photoUrl
            ])
        }
    }
}
