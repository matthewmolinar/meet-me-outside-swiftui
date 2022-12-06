//
//  ProfileFilterButtons.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//

import SwiftUI

enum FilterOptionsProfile: Int, CaseIterable {
    case events
    case qrcode
    
    var text: String {
        switch self {
        case .events: return "Events"
        case .qrcode: return "QR Code"
        }
    }
}

struct FilterButtonView: View {
    @Binding var selectedOption:FilterOptionsProfile
    private let underlineWidth = UIScreen.main.bounds.width / CGFloat(FilterOptionsProfile.allCases.count)
    private var padding: CGFloat {
        let rawValue = CGFloat(selectedOption.rawValue)
        let count = CGFloat(FilterOptionsProfile.allCases.count)
        return (UIScreen.main.bounds.width / count * rawValue + 16)
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(FilterOptionsProfile.allCases, id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                    }, label: {
                        Text(option.text)
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

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView(selectedOption: .constant(.events) )
    }
}
