import SwiftUI

struct SettingRowView: View {
    var title: String
    var systemImageName: String
    
    var body: some View {
        HStack (spacing: 15) {
            Image(systemName: systemImageName)
            Text(title)
            
        }
    }
}

