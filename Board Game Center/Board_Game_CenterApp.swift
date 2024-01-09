//
//  Board_Game_CenterApp.swift
//  Board Game Center
//
//  Created by Michał Gorzkowski on 04/01/2024.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Board_Game_CenterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            let authManager = AuthManager()
            ContentView()
                .environmentObject(authManager)
        }
    }
}
