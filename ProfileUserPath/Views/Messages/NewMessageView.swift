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
    @Binding var user: User?
    @ObservedObject var viewModel = SearchViewModel(config: .newMessage)

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

