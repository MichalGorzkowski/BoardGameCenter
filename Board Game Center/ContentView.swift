//
//  ContentView.swift
//  Board Game Center
//
//  Created by Michał Gorzkowski on 04/01/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        Group {
            if authManager.loggedIn {
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
                    
                    SavedGamesView()
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
                if authManager.isRegistrationViewActive {
                    RegistrationView()
                } else {
                    LoginView()
                }
            }
        }
        .onAppear {
            authManager.loggedIn = authManager.isLoggedIn
        }
    }
}

#Preview {
    ContentView()
}
