////
////  ProfileCreate.swift
////  ProfileUserPath
////
////  Created by Amber Etana Vasquez
//
//
//import SwiftUI
//import Firebase
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//import FirebaseStorage
//import PromiseKit
//
//struct ProfileCreate: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State var name = ""
//    @State var age = ""
//    @State var gradeIndex = 0
//    @State var profileDescription = ""
//    var gradeOptions = ["Freshman", "Sophmore", "Junior", "Senior", "Super Senior", "Graduate"]
//    @State var image = UIImage()
//    @State var showSheet = false
//    @State var loading: Bool = false
//    @State var showAlert: Bool = false
//    @State var alertTitle: String = ""
//    @State var alertMessage: String = ""
//    @State private var user: User? = nil
//    @State private var showCamera = false
//
//    var body: some View {
//        if (showCamera) {
//            CameraView { image in
//                if let image = image {
//                    self.image = image
//                }
//                self.showCamera = false
//            }
//        } else {
//            Form {
//                Section {
//                    TextååField("Name", text: $name)
//                    TextField("Age", text: $age)
//                    Picker(selection: $gradeIndex) {
//                        ForEach(0 ..< gradeOptions.count) { index in
//                            Text(gradeOptions[index])
//                        }
//                    } label: {
//                        Text("Choose Grade")
//                    }
//
//
//               } header: {
//                    Text("Info")
//                }
//
//                Section {
//                    TextEditor(text: $profileDescription)
//                } header: {
//                    Text("Profile Description")
//                }
//
//
//                Section {
//                    Button("Choose Photo") {
//                        showSheet = true
//                    }
//                    Button("Take Photo") {
//                        self.showCamera = true
//                    }
//                    if let image = image, image.cgImage != nil {
//                        Image(uiImage: image)
//                            .resizable()
//                            .aspectRatio(contentMode: ContentMode.fit)
//                            .padding()
//                    } else {
//                        FirebaseImage(id: user?.profilePictureUrl ?? "")
//                            .aspectRatio(contentMode: ContentMode.fit)
//                            .padding()
//                    }
//
//                } header: {
//                    Text("Profile Pic")
//                }
//
//                if loading {
//                    ProgressView("Saving User to Database")
//                }
//
//                Button("Save") {
//                    self.loading = true
//
//                    firstly {
//                        return uploadImage()
//                    }.then { imageUrl in
//                        return createUserObject(imageUrl: imageUrl)
//                    }.done {
//                        self.presentationMode.wrappedValue.dismiss()
//                    }.ensure {
//                        self.loading = false
//                    }.catch { error in
//                        print(error)
//                        self.presentAlert(title: "Uh oh", message: error.localizedDescription)
//                    }
//                }
//
//            }
//            .onAppear {
//                self.loading = true
//                firstly {
//                    self.getUser()
//                }.done { user in
//                    self.user = user
//                }
//                .done({ () in
//                    self.name = user?.name ?? ""
//                    self.age = user?.age ?? ""
//                    self.gradeIndex = gradeOptions.firstIndex(where: { grade in
//                        return grade == (user?.grade ?? "Freshman")
//                    }) ?? 0
//                    self.profileDescription = user?.profileDescription ?? ""
//                })
//                .ensure {
//                    self.loading = false
//                }
//                .catch { error in
//                    self.presentAlert(title: "oh no!", message: error.localizedDescription)
//                }
//            }
//            .navigationTitle("Create profile")
//            .sheet(isPresented: $showSheet) {
//                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
//            }
//            .alert(isPresented: $showAlert) {
//                    Alert(
//                        title: Text(self.alertTitle),
//                        message: Text(self.alertMessage)
//                    )
//                }
//        }
//    }
//
//    func getUser() -> Promise<User> {
//        return Promise { seal in
//            let db = Firestore.firestore()
//            let auth = Auth.auth()
//            guard let authUser = auth.currentUser else {
//                return seal.reject(AppError.error(message: "You are not signed in"))
//            }
//
//            let docRef = db.collection("users").document(authUser.uid)
//            docRef.getDocument { document, error in
//                if let error = error {
//                    print(error)
//                    seal.reject(AppError.error(message: "Unable to get your profile. Please sign back in"))
//                } else {
//                    let data = document?.data()
//                    seal.fulfill(User(
//                        name: data?["name"] as! String,
//                        age: data?["age"] as! String,
//                        grade: data?["grade"] as! String,
//                        profilePicture: data?["profilePicture"] as! String,
//                        profileDescription: data?["profileDescription"] as! String)
//                    )
//                }
//            }
//        }
//    }
//
//    func presentAlert(title: String, message: String) {
//        self.alertTitle = title
//        self.alertMessage = message
//        self.showAlert = true
//    }
//
//    func createUserObject(imageUrl: String) -> Promise<User>  {
//        return Promise { seal in
//            seal.fulfill(User(
//                name: self.name,
//                age: self.age,
//                grade: self.gradeOptions[gradeIndex],
//                profilePicture: imageUrl,
//                profileDescription: self.profileDescription)
//            )
//        }
//    }
//
//    func createUserInFirestore(user: User) -> Promise<Void> {
//        return Promise { seal in
//            let db = Firestore.firestore()
//            do {
//                let auth = Auth.auth()
//                guard let authUser = auth.currentUser else {
//                    return seal.reject(AppError.error(message: "You are not signed in"))
//                }
//                print("USER DICTION \(user.dictionary)")
//                try db.collection("users").document(authUser.uid).setData(user.dictionary)
//                seal.fulfill(())
//            } catch let error {
//                seal.reject(AppError.error(message: "Failed to created user"))
//            }
//        }
//    }
//
//
//    func uploadImage() -> Promise<String> {
//        return Promise { seal in
//            let cgref = image.cgImage
//            let cim = image.ciImage
//
//            if cim == nil && cgref == nil {
//                return seal.fulfill(self.user?.profilePictureUrl ?? "")
//            }
//
//            let auth = Auth.auth()
//            guard let user = auth.currentUser else {
//                return seal.reject(AppError.error(message: "You are not signed in"))
//            }
//            let storage = Storage.storage()
//            let storageRef = storage.reference()
//            let imageRef = storageRef.child("\(user.uid).png")
//
//            // Data in memory
//            guard let data = self.image.pngData() else {
//                return seal.reject(AppError.error(message: "Failed to get image data"))
//            }
//            imageRef.putData(data, metadata: nil) { (metadata, error) in
//                guard let metadata = metadata else {
//                    seal.reject(AppError.error(message: "Uploading Image Error \(error!.localizedDescription)"))
//                    return
//                }
//                if let path = metadata.path {
//                    seal.fulfill(path)
//                } else {
//                    seal.reject(AppError.error(message: "Failed to get url for uploaded image"))
//                }
//
//            }
//        }
//    }
//}
//
//struct ProfileCreate_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCreate()
//    }
//}
//
