//
//  MessageView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 11/27/22.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    
    let message: Message
    
    var body: some View {
           HStack {
               if message.isFromCurrentUser {
                   Spacer()
                   Text(message.text)
                       .padding()
                       .background(Color.blue)
                       .clipShape(ChatBubble(isFromCurrentUser: true))
                       .foregroundColor(.white)
                       .padding(.horizontal)
               } else {
                   HStack {
                       KFImage(URL(string: message.user.profilePictureUrl))
                           .resizable()
                           .scaledToFill()
                           .frame(width: 40, height: 40)
                           .clipShape(Circle())
                       
                       Text(message.text)
                           .padding()
                           .background(Color(.systemGray5))
                           .clipShape(ChatBubble(isFromCurrentUser: false))
                           .foregroundColor(.black)
                       
                   }.padding(.horizontal)
                   Spacer()
               }
               
           }
       }
}

