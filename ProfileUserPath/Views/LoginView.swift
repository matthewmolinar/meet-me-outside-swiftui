//
//  LoginView.swift
//  ProfileUserPath
//
//

import SwiftUI
import Firebase
import FirebaseFirestore
import PromiseKit

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    var completion: () -> Void
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                TextField("Password", text: $password)
                Button("Sign Up") {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                      // TODO: Create user in Firebase Firestore
                        if let error = error {
                            print("Unable  to sign in \(error.localizedDescription)")
                        } else {
                            
                            firstly {
                                self.createUser()
                            }.done { () in
                                self.completion()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func createUser() -> Promise<Void> {
        return Promise { seal in
            let db = Firestore.firestore()
            do {
                let auth = Auth.auth()
                guard let authUser = auth.currentUser else {
                    return seal.reject(AppError.error(message: "You are not signed in"))
                }
                
                try db.collection("users").document(authUser.uid).setData([
                    "name": "Joe Doe",
                    "age": "-",
                    "grade": "-",
                    "profilePicture": "cM5APPYlLEThu3QbBAxP2ffQmSq1.png",
                    "profileDescription": "Go Write your Profile Description!"
                ])
                seal.fulfill(())
            } catch let error {
                seal.reject(AppError.error(message: "Failed to created user"))
            }
        }
    }
    
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView {
            
        }
    }
}
