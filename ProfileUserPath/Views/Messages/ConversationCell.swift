import SwiftUI
import Kingfisher

struct ConversationCell: View {
    
    let message: Message
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                KFImage(URL(string: message.user.profilePictureUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .cornerRadius(28)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.user.name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("Custom Text"))
                    
                    Text(message.text)
                        .font(.system(size: 15))
                        .lineLimit(2)
                        .foregroundColor(Color("Custom Text"))
                }
                .foregroundColor(.black)
                .padding(.trailing)
                Spacer()
            }
            Divider()
        }
    }
}

