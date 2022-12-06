//
//  EditProfileViewModel.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case desc
    
    var description: String {
        switch self {
        case .fullname: return "Name"
        case .username: return "Username"
        case .desc: return "Desc"
        }
    }
    
    func optionValue(user: User) -> String {
        switch self {
        case .fullname: return user.name
        case .username: return user.username
        case .desc: return user.profileDescription ?? "Edit your user description!"
        }
    }
    
    
}

