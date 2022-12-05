import SwiftUI


struct ProfileView: View {
    let user: User
    

    
    var body: some View {
        VStack {
            ProfileHeaderView()
                .padding()
            ProfileActionButtonView()
            
            ScrollView {
                Text("Ok!")
                }
            .navigationTitle(user.name)
            }
        }
    }

