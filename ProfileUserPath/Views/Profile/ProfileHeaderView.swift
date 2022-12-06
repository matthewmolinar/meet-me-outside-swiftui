import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    let viewModel: ProfileViewModel
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.user.profilePictureUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .shadow(color: .black, radius: 3, x:0.0, y:0.0)
            
            Text(viewModel.user.name)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 8)
            
            Text(viewModel.user.profileDescription)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack(spacing: 40) {
                Text(viewModel.user.age)
                Text(viewModel.user.grade)
                Text("UT-Austin")
            }.padding()
            
                .navigationTitle(viewModel.user.username)
            
        }
    }
}

