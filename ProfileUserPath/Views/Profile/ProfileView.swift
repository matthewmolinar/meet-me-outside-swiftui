import SwiftUI


struct ProfileView: View {
    let user: User
    
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    

    
    var body: some View {
        VStack {
            ProfileHeaderView(viewModel: viewModel)
                .padding()
            ProfileActionButtonView()
            
            ScrollView {
                Text("Ok!")
                }
            .navigationTitle(user.name)
            }
        }
    }

