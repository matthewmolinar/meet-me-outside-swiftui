//
//  ContentView.swift
//  ProfileUserPath
//
//

import SwiftUI
import Firebase
import PromiseKit
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
    
    @State var user: User? = nil
    @State var showSheet = false
    @State var loading: Bool = false
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var showQRScanner: Bool = false
    @State var qRImageGenerator = QRImageGenerator(message: "Not Set")
    
    func getUser() -> Promise<User> {
        return Promise { seal in
            let db = Firestore.firestore()
            let auth = Auth.auth()
            guard let authUser = auth.currentUser else {
                return seal.reject(AppError.error(message: "You are not signed in"))
            }
            
            let docRef = db.collection("users").document(authUser.uid)
            docRef.getDocument { document, error in
                if let error = error {
                    print(error)
                    seal.reject(AppError.error(message: "Unable to get your profile. Please sign back in"))
                } else {
                    let data = document?.data()
                    print("---------THE USER DATA: \(data)")
                    seal.fulfill(User(
                        name: data?["name"] as! String,
                        age: data?["age"] as! String,
                        grade: data?["grade"] as! String,
                        profilePicture: data?["profilePicture"] as! String,
                        profileDescription: data?["profileDescription"] as! String)
                    )
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            
            TabView {
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        if (showQRScanner) {
                            ScannerView()
                        } else {
                            if (self.loading) {
                                Spacer()
                                ProgressView {
                                    Text("Loading Profile...")
                                }
                                Spacer()
                            } else {
                                FirebaseImage(id: user?.profilePicture ?? "")
                                    .aspectRatio(contentMode: ContentMode.fit)
                                    .padding()
                                VStack {
                                    Text(user?.name ?? "UNKNOWN")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.system(Font.TextStyle.largeTitle,design: .rounded))
                                        .bold()
                                        .padding(.bottom)
                                    HStack {
                                        Text("\(user?.age ?? "-"), UT \(self.user?.grade ?? "-")")
                                            .bold()
                                            .font(.system(Font.TextStyle.subheadline,design: .rounded))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.bottom])
                                    HStack {
                                        Image(systemName: "quote.bubble")
                                        Text("About")
                                            .bold()
                                            .font(.system(Font.TextStyle.subheadline,design: .rounded))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.bottom])
                                    
                                    VStack {
                                        HStack {
                                            Text(user?.profileDescription ?? "Needs to be written")
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text("Scan QR Code to Read Profile Description")
                                            .padding()
                                        
                                        if let image = qRImageGenerator.image {
                                            Image(uiImage: image)
                                        }
                                    }
                                    
                                }
                                .padding()
                                Spacer()
                            }
                        }
                    }
                    .onAppear {
                        self.loading = true
                        firstly {
                            self.getUser()
                        }.done { user in
                            self.user = user
                        }
                        .done({
                            self.qRImageGenerator = QRImageGenerator(message: self.user?.profileDescription ?? "Not Set")
                        })
                        .ensure {
                            self.loading = false
                        }
                        .catch { error in
                            self.presentAlert(title: "oh no!", message: error.localizedDescription)
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
                .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(self.alertTitle),
                            message: Text(self.alertMessage)
                        )
                }
                .navigationTitle("Your Profile")
                .toolbar {
                    if (!showQRScanner) {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            NavigationLink(destination: ProfileCreate()) {
                                Text("Edit Profile")
                            }
                        }
                        
                        // 2
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button("QR Code") {
                                self.showQRScanner = true
                            }
                        }
                    } else {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button("Dismiss QR Scanner") {
                                self.showQRScanner = false
                            }
                        }
                    }
                }
                // Second tab
                // TODO: Groups
                ConservationsView()
                    .tabItem {
                        Image(systemName: "envelope.circle.fill")
                        Text("Groups")
                    }
                
                
                
                // Third tab TODO: Calendar
                Text("Calendar")
                    .tabItem {
                        Image(systemName: "calendar.circle.fill")
                        Text("Calendar")
                    }
            }
            
        }
    }
    
    func presentAlert(title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
        self.showAlert = true
    }
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
