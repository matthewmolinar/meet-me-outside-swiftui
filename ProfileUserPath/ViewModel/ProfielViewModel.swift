//
//  ProfielViewModel.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI
import Firebase


class ProfileViewModel: ObservableObject {
    let user: User
    
    
    init(user: User) {
        self.user = user
    }
}
