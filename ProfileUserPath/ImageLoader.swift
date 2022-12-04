//
//  ImageLoader.swift
//  ProfileUserPath
//
//

import Foundation
import SwiftUI
import Combine
import FirebaseStorage

final class Loader: ObservableObject {
    
    @Published var isLoading = false
    let didChange = PassthroughSubject<Data?, Never>()
    @Published var data: Data? = nil {
        didSet { didChange.send(data) }
    }

    init(_ id: String){
        self.isLoading = true
        // the path to the image
        let url = "\(id)"
        print("THE URLS for image: \(url)")
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 30 * 1024 * 1024) { data, error in
            if let error = error {
                print("\(error)")
            }

            DispatchQueue.main.async {
                self.data = data
            }
            
            self.isLoading = false
        }
    }
}
