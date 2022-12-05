//
//  ProfileActionButtonView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var editProfileShowing: Bool
    
    let fakeData = ["email": "fake@email.com",
                "username": "error",
                "fullname": "error",
                "profileImageUrl": "error",
                "uid": "error"]
    
    var body: some View {
        HStack {
            Button(action: {
                
                editProfileShowing.toggle()
            }) {
                Text("Edit Profile")
                    .frame(width: 180, height: 40)
                    .background(Color.green)
                    .foregroundColor(.white)
            }
            .cornerRadius(20)
            .fullScreenCover(isPresented: $editProfileShowing) {
                EditProfileView(isShowing: $editProfileShowing, user: viewModel.user ?? User(dictionary: fakeData))
            }
            
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
        ProfileActionButtonView(editProfileShowing: .constant(false))
    }
}
