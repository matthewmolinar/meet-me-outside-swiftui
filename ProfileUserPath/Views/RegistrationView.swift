//
//  RegistrationView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct RegistrationView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                TextField("Password", text: $password)
                Button("Sign Up") {
                    viewModel.registerUser(email: email, password: password)
                    
                }
            }
        }
    }
    
    
    func registerUser(email: String, password: String, name: String,age: String, grade: String, profilePicture: String, profileDescription: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            
            let data = [
                "email": $email,
                "name": "Joe Doe",
                "age": "-",
                "grade": "-",
                "profilePicture": "cM5APPYlLEThu3QbBAxP2ffQmSq1.png",
                "profileDescription": "Go Write your Profile Description!"
            ]
            
            Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                return
            }
        }
    }
}



struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
