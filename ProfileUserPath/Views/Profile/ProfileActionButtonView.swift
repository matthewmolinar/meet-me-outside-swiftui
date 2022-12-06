import SwiftUI

struct ProfileActionButtonView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var editProfileShowing: Bool
    let isCurrentUser: Bool
    let profileViewModel: ProfileViewModel
    
    let fakeData = ["email": "fake@email.com",
                "username": "error",
                "fullname": "error",
                "profileImageUrl": "error",
                "uid": "error"]
    
    var body: some View {
        VStack {
            if isCurrentUser {
                HStack {
                Button(action: {
                    
                    editProfileShowing.toggle()
                }) {
                    Text("Edit Profile")
                        .frame(width: 120, height: 40)
                        .foregroundColor(Color("Profile Custom Text"))
                }
                .background(Color("Custom Accent"))
                .cornerRadius(20)
                .fullScreenCover(isPresented: $editProfileShowing) {
                    EditProfileView(isShowing: $editProfileShowing, user: viewModel.user ?? User(dictionary: fakeData))
                }
                
                Button(action: {
                    viewModel.signOut()
                }) {
                    Text("Sign Out")
                        .frame(width: 120, height: 40)
                        .foregroundColor(Color("Profile Custom Text"))
                        
                }
                .background(Color("Custom Accent"))
                .cornerRadius(20)
                
                
                }
            } else {
                NavigationLink(destination: ChatView(user: profileViewModel.user)) {
                    Text("Message")
                        .frame(width: 360, height: 40)
                        .foregroundColor(Color("Profile Custom Text"))
                }
                .background(Color("Custom Accent"))
                .cornerRadius(20)
            }
        }
    }
}

