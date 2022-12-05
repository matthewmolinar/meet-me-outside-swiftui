//
//  EditProfileView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
