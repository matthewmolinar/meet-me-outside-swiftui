//
//  SettingsView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            List {
                Section(header: Text("Account")) {
                    NavigationLink(destination: PasswordChangeView()) {
                        SettingRowView(title: "Password", systemImageName: "lock")
                    }
                    NavigationLink(destination: DeleteAccountView()) {
                        SettingRowView(title: "Delete Account", systemImageName: "trash.fill")
                    }
                    
                }
                Section(header: Text("Appearance")) {
                    NavigationLink(destination: FontChangeView()) {
                        SettingRowView(title: "Fonts", systemImageName: "textformat")
                    }
                    NavigationLink(destination: FontChangeView()) {
                        SettingRowView(title: "Dark Mode", systemImageName: "circle.lefthalf.filled")
                    }
                    NavigationLink(destination: ColorSchemeChangeView()) {
                        SettingRowView(title: "Color Scheme", systemImageName: "paintbrush.pointed.fill")
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
