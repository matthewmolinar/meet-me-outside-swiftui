//
//  ProfileUserPathApp.swift
//  ProfileUserPath
//
//

import SwiftUI
import FirebaseCore
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
//    try? Auth.auth().signOut()
    return true
  }
}



@main
struct ProfileUserPathApp: App {
    @State private var isLoggedIn = false
    @StateObject var userEvents = EventStore(preview: true)
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn || Auth.auth().currentUser != nil {
                ContentView()
                    .environmentObject(userEvents)
            } else {
                LoginView {
                    isLoggedIn = true
                }
            }
        }
    }
}
