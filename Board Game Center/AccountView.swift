//
//  AccountView.swift
//  Board Game Center
//
//  Created by Michał Gorzkowski on 09/01/2024.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        VStack {
            Text("AccountView")
            
            Button(action: {
                authManager.signOut()
            }, label: {
                Text("Sign Out")
            })
        }
        
        
    }
}

#Preview {
    AccountView()
}
