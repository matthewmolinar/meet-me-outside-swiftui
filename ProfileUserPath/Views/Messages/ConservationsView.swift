//
//  ConservationsView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 11/27/22.
//

import SwiftUI

struct ConservationsView: View {
    // state variable that determines if this view is presented or not
    @State var isShowingNewMessageView = false
    @State var searchText = ""
    @State var user: User?
    @State var showChat = false
    
    @ObservedObject var viewModel = ConversationsViewModel()
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let user = user {
                NavigationLink(destination: ChatView(user: user),
            isActive: $showChat,
            label: {})
            }
            ScrollView {
                SearchBar(text: $searchText)
                VStack {
                    ForEach(viewModel.recentMessages) { message in
                        NavigationLink(destination: ChatView(user: message.user), label: {
                            ConversationCell(message: message)
                        })
                    }
                }.padding()
            }
            
            // toggle the state var
            Button(action: { self.isShowingNewMessageView.toggle() }, label: {
                Image(systemName: "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color("Custom Accent"))
            .foregroundColor(Color("Profile Custom Text"))
            .clipShape(Circle())
            .padding()
            // state var determines if this sheet is shown or not.
            .sheet(isPresented: $isShowingNewMessageView, content: {
                NewMessageView(show: $isShowingNewMessageView, startChat: $showChat, user: $user)
            })
        }
    }
}

struct ConservationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConservationsView()
    }
}
