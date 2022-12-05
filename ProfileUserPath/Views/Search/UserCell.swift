//
//  UserCell.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 11/27/22.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack {
                    // user profile img
                    KFImage(URL(string: user.profilePictureUrl))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 56, height: 56)
                        .cornerRadius(28)
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.username)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text(user.name)
                            .font(.system(size: 14))
                    }
                }
    }
}

