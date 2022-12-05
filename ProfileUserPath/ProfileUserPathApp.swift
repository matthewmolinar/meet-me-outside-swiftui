import SwiftUI
import FirebaseCore
import Firebase





@main
struct ProfileUserPathApp: App {
    @State private var isLoggedIn = false
    @StateObject var userEvents = EventStore(preview: false)
    @StateObject var globalFont = FontStore()
    @StateObject var darkModeConfig = DarkModeStore()
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            
            ContentView().environmentObject(userEvents)
                .environmentObject(AuthViewModel.shared)
                .environmentObject(globalFont)
                .environmentObject(darkModeConfig)
                .font(Font.custom(globalFont.fontName, size: 20))
                .environment(\.colorScheme, darkModeConfig.colorSchemeProperty)
        }
    }
}
