//
//  SocialView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

struct SocialView: View {
    @State var selectedFilter: MessageFilterOptions = .users
    
    var body: some View {
        VStack {
            MessageFilterButtonView(selectedOption: $selectedFilter)
            Spacer()
            if selectedFilter == .users {
                SearchView()
            } else {
                ConservationsView()
            }
        }
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
