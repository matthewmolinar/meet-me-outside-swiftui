//
//  RegistrationView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Kingfisher

struct RegistrationView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var username: String = ""
    @State var name: String = ""
    @State var imagePickerShowing = false
    @State var image = UIImage()

    @EnvironmentObject var viewModel: AuthViewModel
    
   
    var body: some View {
        Form {
            Button(action: {
                imagePickerShowing.toggle()
                
            })
            
            {
                ZStack {
                    if let image = image, image.cgImage != nil {
                        HStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                            Spacer()
                            Text("Nice one!")
                            Spacer()
                        }
                    } else {
                        HStack {
                            Image("batman")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                            Spacer()
                            Text("Upload your profile picture here")
                        }
                    }
                    
                    
                }
            }
            .sheet(isPresented: $imagePickerShowing) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
            }
            Section {
                TextField("Email", text: $email)
                TextField("Password", text: $password)
                TextField("User Name", text: $username)
                TextField("Full Name", text: $name)

                Button("Sign Up") {
                    viewModel.registerUser(email: email, password: password, username: username, name: name, profileImage: image)
                }
                
                
            }
            
        }
        .navigationTitle("Register")
    }
    
    
    
}



struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
