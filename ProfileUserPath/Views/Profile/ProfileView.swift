import SwiftUI


struct ProfileView: View {
    let user: User
    @State private var editProfileShowing = false
    @ObservedObject var viewModel: ProfileViewModel
    @State private var formType: EventFormType?
    @State var selectedFilter: FilterOptionsProfile = .events
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
        
    }
    

    
    var body: some View {
        VStack {
            ProfileHeaderView(viewModel: viewModel)
                .padding()
            ProfileActionButtonView(editProfileShowing: $editProfileShowing)
            
            FilterButtonView(selectedOption: $selectedFilter)
            
            ScrollView {
                if selectedFilter == .events {
                    ForEach(viewModel.userEvents) { event in
                        ListViewRow(event: event, formType: $formType)
                            .padding()
                    }
                }
                }
            
        

            }
        }
    }

