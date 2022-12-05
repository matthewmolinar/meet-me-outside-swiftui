//
//  SettingsView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

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
                
            }
            
        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
