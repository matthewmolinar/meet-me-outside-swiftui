//
//  ProfileActionButtonView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        HStack {
            Button(action: {}) {
                Text("Edit Profile")
                    .frame(width: 180, height: 40)
                    .background(Color.green)
                    .foregroundColor(.white)
            }
            .cornerRadius(20)
            
            Button(action: {
                viewModel.signOut()
            }) {
                Text("Sign Out")
                    .frame(width: 180, height: 40)
                    .background(Color.green)
                    .foregroundColor(.white)
            }
            .cornerRadius(20)
        }
    }
}

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView()
    }
}
