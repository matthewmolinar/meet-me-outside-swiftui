//
//  ProfileUserPathApp.swift
//  ProfileUserPath
//
//

import SwiftUI
import FirebaseCore
import Firebase





@main
struct ProfileUserPathApp: App {
    @State private var isLoggedIn = false
    @StateObject var userEvents = EventStore(preview: false)
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userEvents)
                .environmentObject(AuthViewModel.shared)
        }
    }
}
