import Foundation

class FontStore: ObservableObject {
    @Published var fontName: String
    
    init() {
        self.fontName = "DIN Alternate" 
    }
}
