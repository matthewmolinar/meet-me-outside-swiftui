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
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Email", text: $email)
                        TextField("Password", text: $password)
                        Button("Sign In") {
                            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                                if let error = error {
                                    print("DEBUG: failed to login \(error.localizedDescription)")
                                    return
                                }
                            }
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
