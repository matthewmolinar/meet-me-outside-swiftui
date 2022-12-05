//
//  SettingsView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @State var showDeleteAccountAlert = false
    var body: some View {
        VStack {
            List {
                
                Section(header: Text("Appearance")) {
                    NavigationLink(destination: FontChangeView()) {
                        SettingRowView(title: "Fonts", systemImageName: "textformat")
                    }
                    NavigationLink(destination: DarkModeToggleView()) {
                        SettingRowView(title: "Dark Mode", systemImageName: "circle.lefthalf.filled")
                    }
                    
                }
                
                Section(header: Text("Account")) {
                    Button(action: {
                        showDeleteAccountAlert.toggle()
                    }) {
                        SettingRowView(title: "Delete Account", systemImageName: "trash.fill")
                    
                        .foregroundColor(.red)
                    }
                    .alert(isPresented: $showDeleteAccountAlert) {
                        Alert(title: Text("Are you sure you want to delete your account?"), message: Text("This action cannot be undone."), primaryButton: .default(Text("Cancel"), action: {}), secondaryButton: .destructive(Text("Delete Account"), action: {
                            // delete account
                            AuthViewModel.shared.userSession?.delete()
                            AuthViewModel.shared.userSession = nil
                        }))
                    }
                        
                    
                }
                
                Section(header: Text("Privacy")) {
                    Button(action: {
                        let center = UNUserNotificationCenter.current()
                        center.getNotificationSettings(completionHandler: { settings in
                            if settings.authorizationStatus != .authorized {
                                // request for notification permissions for alert, sound and badge
                                center.requestAuthorization(options: [.alert, .sound, .badge]) {
                                   granted, error in

                                   if let error = error {
                                        // handle the error here
                                        print("error : \(error)")
                                   }
                                }
                            }
                        })
                        let content = UNMutableNotificationContent()
                        content.title = "Take a break"
                        content.subtitle = "Please stop working now"
                        content.sound = UNNotificationSound.default

                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                        let request = UNNotificationRequest(identifier: "swaggggg", content: content,
                           trigger:trigger)

                        UNUserNotificationCenter.current().add(request)
                    } ){
                        SettingRowView(title: "Allow Notifications", systemImageName: "exclamationmark.bubble")
                    }
                        
                    
                    
                }
                
            }
            
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
