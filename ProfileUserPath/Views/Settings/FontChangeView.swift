//
//  FontChangeView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

struct FontChangeView: View {
    @EnvironmentObject var globalFont: FontStore
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Fonts")
                Spacer()
            }
            Button(action: {
                if globalFont.fontName == "DIN Alternate" {
                    globalFont.fontName = "Arial-Narrow"
                } else {
                    globalFont.fontName = "DIN Alternate"
                }
            }) {
                if globalFont.fontName == "DIN Alternate" {
                    Text("Change Font to Arial Narrow")
                } else {
                    Text("Change Font to DIN Alternate")
                }
            }
        }
    }
}

struct FontChangeView_Previews: PreviewProvider {
    static var previews: some View {
        FontChangeView()
    }
}
