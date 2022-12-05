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
    
    
    
}



struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
