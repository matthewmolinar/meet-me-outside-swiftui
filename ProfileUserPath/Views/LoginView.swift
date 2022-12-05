//
//  LoginView.swift
//  ProfileUserPath
//
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Email", text: $email)
                        SecureField("Password", text: $password)
                        Button("Sign In") {
                            viewModel.login(withEmail: email, password: password)
                        }
                    }
                }
                NavigationLink(destination: RegistrationView() ) {
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 14))
                            Text("Sign up")
                            .font(.system(size: 14, weight: .semibold))
                        
                    }
                }
                .padding(.bottom, 50)
                Spacer()
            }
        }
    }
    

    
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
