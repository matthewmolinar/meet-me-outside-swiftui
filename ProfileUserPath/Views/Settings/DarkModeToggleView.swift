//
//  DarkModeToggleView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

struct DarkModeToggleView: View {
    @EnvironmentObject var darkModeConfig: DarkModeStore
    @State var darkModeIsOn = true

    
    var body: some View {
        VStack {
            
            Toggle("Dark mode", isOn: $darkModeIsOn)
                .onChange(of: darkModeIsOn) { value in
                    if darkModeIsOn {
                        darkModeConfig.colorSchemeProperty = .dark

                    } else {
                        darkModeConfig.colorSchemeProperty = .light

                        }
                    }
                .toggleStyle(SwitchToggleStyle(tint: .green))
            Spacer()
        }.padding()
    }
}

