//
//  SettingRowView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

struct SettingRowView: View {
    var title: String
    var systemImageName: String
    
    var body: some View {
        HStack (spacing: 15) {
            Image(systemName: systemImageName)
            Text(title)
            
        }
    }
}

