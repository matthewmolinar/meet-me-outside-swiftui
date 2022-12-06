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
            ProfileActionButtonView(editProfileShowing: $editProfileShowing, isCurrentUser: viewModel.user.isCurrentUser, profileViewModel: viewModel)
            
            FilterButtonView(selectedOption: $selectedFilter)
            
            ScrollView {
                if selectedFilter == .events {
                    if viewModel.userEvents.count > 0 {
                        ForEach(viewModel.userEvents) { event in
                            ProfileListViewRow(event: event, formType: $formType)
                                .padding()
                        }
                    } else {
                        EmptyListViewRow()
                    }
                    
                }
                }
            .background(Color("Custom ScrollView"))
            .navigationTitle(user.name)
            
        

            }
        }
    }

