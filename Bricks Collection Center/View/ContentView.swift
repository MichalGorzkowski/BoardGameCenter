//
//  ContentView.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 04/01/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        Group {
            if firebaseManager.loggedIn {
                TabView {
                    MainScreenView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Dashboard")
                        }
                    
                    DiscoverView()
                        .tabItem {
                            Image(systemName: "timelapse")
                            Text("Discover")
                        }
                    
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    
                    SavedSetsView()
                        .tabItem {
                            Image(systemName: "square.stack.3d.up.fill")
                            Text("Collection")
                        }
                    
                    AccountView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Account")
                        }
                }
            } else {
                if firebaseManager.isRegistrationViewActive {
                    RegistrationView()
                } else {
                    LoginView()
                }
            }
        }
        .onAppear {
            firebaseManager.loggedIn = firebaseManager.isLoggedIn
        }
    }
}
