//
//  EditProfileView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    @Binding var isShowing: Bool
    @ObservedObject var viewModel: EditProfileViewModel
    let user: User
    

    
    init(isShowing: Binding<Bool>, user: User) {
        self._isShowing = isShowing
        self.user = user
        self.viewModel = EditProfileViewModel(user: user)
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isShowing.toggle()
                }) {
                    Text("Cancel")
                }
                Spacer()
                Text("Edit Profile")
                Spacer()
                Button(action: {
                    isShowing.toggle()
                }) {
                    Text("Done")
                }
            }.padding()
            
            VStack {
                KFImage(URL(string: user.profilePictureUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                
                Button(action: {
                    
                }) {
                    Text("Change your profile photo")
                }
            }
            
        }
    }
}

let fakeData = ["email": "fake@email.com",
            "username": "error",
            "fullname": "error",
            "profileImageUrl": "error",
            "uid": "error"]

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(isShowing: .constant(false), user: User(dictionary: fakeData))
    }
}
