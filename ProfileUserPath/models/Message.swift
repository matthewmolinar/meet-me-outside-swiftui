//
//  Message.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 11/27/22.
//

import Foundation



struct MockMessage: Identifiable {
    let id: Int
    let imageName: String
    let messageText: String
    let isCurrentUser: Bool
}



let MOCK_MESSAGES: [MockMessage] = [
    .init(id: 0, imageName: "batman", messageText: "Hey what's up?", isCurrentUser: false),
    .init(id: 1, imageName: "ProfilePic", messageText: "nm u??", isCurrentUser: true),
    .init(id: 2, imageName: "batman", messageText: "...", isCurrentUser: false),
    .init(id: 3, imageName: "ProfilePic", messageText: "sooo?", isCurrentUser: true),
    .init(id: 4, imageName: "batman", messageText: "I'm batman.", isCurrentUser: false),
    .init(id: 5, imageName: "ProfilePic", messageText: "u literlly texted me..", isCurrentUser: true),
]

