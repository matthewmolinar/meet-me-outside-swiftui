//
//  NewMessageView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 11/28/22.
//

import SwiftUI

struct NewMessageView: View {
    @State var searchText = ""
    @Binding var show: Bool

    @Binding var startChat: Bool
    @Binding var user: User?
    @ObservedObject var viewModel = SearchViewModel(config: .newMessage)

    var body: some View {
        
            ScrollView {
                SearchBar(text: $searchText)
                    .padding()
                
                VStack(alignment: .leading) {
                                ForEach(searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)) { user in
                                    HStack { Spacer() }
                                    
                                    Button(action: {
                                        self.show.toggle()
                                        self.startChat.toggle()
                                        self.user = user
                                    }) {
                                        UserCell(user: user)
                                    }
                                }
                            }.padding(.leading)
            }
        }
    }

