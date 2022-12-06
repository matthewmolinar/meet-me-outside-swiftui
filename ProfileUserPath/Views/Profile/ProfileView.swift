import SwiftUI
import CoreImage.CIFilterBuiltins


struct ProfileView: View {
    let user: User
    
    @State private var editProfileShowing = false
    @ObservedObject var viewModel: ProfileViewModel
    @State private var formType: EventFormType?
    @State var selectedFilter: FilterOptionsProfile = .events
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
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
                    
                } else {
                    Image(uiImage: generateQRCode(from: "\(user.name)\n\(user.username)"))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                }
            .background(Color("Custom ScrollView"))
            .navigationTitle(user.name)
            
        

            }
        }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    }

