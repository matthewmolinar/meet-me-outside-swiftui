//
//  EditProfileView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI
import Kingfisher
import Firebase
import FirebaseStorage

struct EditProfileView: View {
    @Binding var isShowing: Bool
    @ObservedObject var viewModel: EditProfileViewModel
    let user: User
    @State private var showCamera = false
    @State var image = UIImage()
    @State var showSheet = false
    @State var name: String
    @State var username: String
    @State var description: String
    @State var showProfileEditAlert = false
    @State var showNameEditAlert = false
    @State var showUserNameEditAlert = false
    

    
    init(isShowing: Binding<Bool>, user: User) {
        self._isShowing = isShowing
        self.user = user
        self.viewModel = EditProfileViewModel(user: user)
        self.name = user.name
        self.username = user.username
        self.description = user.profileDescription
    }

    var body: some View {
        if (showCamera) {
            CameraView { image in
                if let image = image {
                    self.image = image
                }
                self.showCamera = false
            }
        } else {
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
                        // update firebase
                        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
                        let filename = NSUUID().uuidString
                        let storageRef = Storage.storage().reference().child(filename)
                        
                        storageRef.putData(imageData, metadata: nil) { _, error in
                            if let error = error {
                                print("DEBUG: failed to upload image: \(error.localizedDescription)")
                                return
                            }
                            
                            storageRef.downloadURL { url, _ in
                                guard let profileImageUrl = url?.absoluteString else { return }
                                
                                print("DEBUG: profileImageUrl \(profileImageUrl)")
                                
                                guard let uid = AuthViewModel.shared.userSession?.uid else { return }
                                print("DEBUG: uid \(uid)")
                                let docRef = Firestore.firestore().collection("users").document(uid)
                                
                                docRef.updateData([
//                                    "name": $name,
//                                    "username": $username,
//                                    "description": $description,
                                    "profilePictureUrl": profileImageUrl
                                ])
                            }
                        }
                        isShowing.toggle()
                    }) {
                        Text("Done")
                    }
                }.padding()
                
                VStack {
                    if let image = image, image.cgImage != nil {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                        
                    } else {
                        KFImage(URL(string: user.profilePictureUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                    }
                    
                    
                    Button(action: {
                        showSheet = true
                    }) {
                        Text("Change your profile photo")
                    }.padding(.bottom, 25)
                    
                    Button(action: {
                        self.showCamera = true
                    }) {
                        Text("Take a photo")
                    }
                }
                               VStack {
                                   HStack(alignment: .center, spacing: 64) {
                                       Text("Name")
                                           .font(.system(size: 14, weight: .semibold))
                                           .frame(width: 100)
                                           
                                       
                                       Text(user.name)
                                           .font(.system(size: 15))
                                           .foregroundColor(.blue)
                                           .onTapGesture {
                                               showNameEditAlert = true
                                           }
                                       Spacer()
                                       
                                   }
                                   .padding(.top, -16)
                                   Divider()
                               }.padding()
                    .alert("Edit", isPresented: $showNameEditAlert, actions: {
                        TextField("\(user.name)", text: $name)
                        
                        Button("Done", action: {})
                        Button("Cancel", role: .cancel, action: {})
                    })
                
                           VStack {
                               HStack(alignment: .center, spacing: 64) {
                                   Text("Username")
                                       .font(.system(size: 14, weight: .semibold))
                                       .frame(width: 100)
                                       
                                   
                                   Text(user.username)
                                       .font(.system(size: 15))
                                       .foregroundColor(.blue)
                                       .onTapGesture {
                                           showUserNameEditAlert = true
                                       }
                                   Spacer()
                                   
                               }
                               .padding(.top, -16)
                               Divider()
                           }
                           .padding()
                           .alert("Edit", isPresented: $showUserNameEditAlert, actions: {
                               TextField("\(user.username)", text: $username)
                               
                               Button("Done", action: {})
                               Button("Cancel", role: .cancel, action: {})
                           })
                
                           VStack {
                               HStack(alignment: .center, spacing: 64) {
                                   Text("Description")
                                       .font(.system(size: 14, weight: .semibold))
                                       .frame(width: 100)
                                       
                                   
                                   Text(user.profileDescription)
                                       .font(.system(size: 15))
                                       .foregroundColor(.blue)
                                       .onTapGesture {
                                           showProfileEditAlert = true
                                       }
                                   Spacer()
                                   
                               }
                               .padding(.top, -16)
                               Divider()
                           }
                           .padding()
                           .alert("Edit", isPresented: $showProfileEditAlert, actions: {
                               TextField("\(user.profileDescription)", text: $description)
                               
                               Button("Done", action: {})
                               Button("Cancel", role: .cancel, action: {})
                           })
                Spacer()
                
            }
            .sheet(isPresented: $showSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
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
