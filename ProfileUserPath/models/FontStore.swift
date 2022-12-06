//
//  FontStore.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/5/22.
//
import Foundation

class FontStore: ObservableObject {
    @Published var fontName: String
    
    init() {
        self.fontName = "DIN Alternate" 
    }
}
