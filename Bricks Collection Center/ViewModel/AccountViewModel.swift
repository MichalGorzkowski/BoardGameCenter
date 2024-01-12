//
//  AccountViewModel.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 12/01/2024.
//

import Foundation

class AccountViewModel: ObservableObject {
    var firebaseManager = FirebaseManager()
    
    func getData() {
        firebaseManager.getUserDataFromFirebase()
    }
}
