import Foundation
import SwiftUI


class DarkModeStore: ObservableObject {
    @Published var colorSchemeProperty: ColorScheme = .dark
    
    init() {
        
    }
    
    
    
}
