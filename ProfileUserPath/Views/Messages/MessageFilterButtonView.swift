import SwiftUI

enum MessageFilterOptions: Int, CaseIterable {
    case users
    case messages
    
    var title: String {
        switch self {
        case .users: return "Users"
        case .messages: return "Messages"
        }
    }
}

struct MessageFilterButtonView: View {
    @Binding var selectedOption:MessageFilterOptions
    private let underlineWidth = UIScreen.main.bounds.width / CGFloat(MessageFilterOptions.allCases.count)
    private var padding: CGFloat {
        let rawValue = CGFloat(selectedOption.rawValue)
        let count = CGFloat(MessageFilterOptions.allCases.count)
        return (UIScreen.main.bounds.width / count * rawValue + 16)
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(MessageFilterOptions.allCases, id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                    }, label: {
                        Text(option.title)
                            .frame(width: underlineWidth - 4)
                    })
                }
            }
            Rectangle()
                .frame(width: underlineWidth - 24, height: 3, alignment: .center)
                .foregroundColor(Color("Custom Accent"))
                .padding(.leading, padding)
                .animation(.spring())
                
        }
    }
}

struct GodFilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MessageFilterButtonView(selectedOption: .constant(.users))
    }
}
