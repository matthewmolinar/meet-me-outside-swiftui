//
//  NewMessageView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 11/28/22.
//

import SwiftUI

struct NewMessageView: View {
    @State var searchText = ""
    @Binding var startChat: Bool
    @Binding var show: Bool

    var body: some View {
        
            ScrollView {
                SearchBar(text: $searchText)
                    .padding()
                
                VStack(alignment: .leading) {
                    ForEach(0..<10) { _ in
                        HStack { Spacer() }
                        UserCell()
                    }
                }.padding(.leading)
            }
        }
    }

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(startChat: .constant(true), show: .constant(true))
    }
}
