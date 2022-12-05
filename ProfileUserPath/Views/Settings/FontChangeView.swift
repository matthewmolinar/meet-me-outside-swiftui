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
                globalFont.fontName = "AmericanTypewriter-Bold"
            }) {
                Text("Change Font")
            }
        }
    }
}

struct FontChangeView_Previews: PreviewProvider {
    static var previews: some View {
        FontChangeView()
    }
}
