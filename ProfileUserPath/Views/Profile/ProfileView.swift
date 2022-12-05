import SwiftUI


struct ProfileView: View {
    

    
    var body: some View {
        VStack {
            ProfileHeaderView()
                .padding()
            ProfileActionButtonView()
            
            ScrollView {
                Text("Ok!")
                }
            }
        }
    }

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

