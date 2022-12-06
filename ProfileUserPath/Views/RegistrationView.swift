import SwiftUI
import Firebase
import FirebaseFirestore
import Kingfisher

struct RegistrationView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var username: String = ""
    @State var name: String = ""
    @State var age = ""
    @State var imagePickerShowing = false
    @State var image = UIImage()
    var gradeOptions = ["Freshman", "Sophmore", "Junior", "Senior", "Super Senior", "Graduate"]
    @State var gradeIndex = 0
    @State var grade: String = ""

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
                TextField("Age", text: $age)
//                Picker(selection: $gradeIndex) {
//                    ForEach(0 ..< gradeOptions.count) { index in
//                        Text(gradeOptions[index])
//                    }
//                } label: {
//                    Text("Choose Grade")
//                }
//                .onChange(of: $gradeIndex) {
//                    $grade = gradeOptions[$gradeIndex]
//                }
                TextField("Grade", text: $grade)

                Button("Sign Up") {
                    viewModel.registerUser(email: email, password: password, username: username, name: name, profileImage: image, age: age, grade: grade)
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
