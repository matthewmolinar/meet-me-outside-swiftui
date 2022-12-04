//
//  FirebaseImage.swift
//  ProfileUserPath
//
//
import Foundation
import SwiftUI

let placeholder = UIImage(named: "ProfilePic.jpg")!

struct FirebaseImage : View {

    @ObservedObject private var imageLoader : Loader = Loader("")

    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }

    init(id: String) {
        self.imageLoader = Loader(id)
    }

    var body: some View {
        if (imageLoader.isLoading) {
            ProgressView {
                Text("Loading Image")
            }
        } else {
            Image(uiImage: image ?? placeholder)
                .resizable()
        }
    }
}

struct FirebaseImage_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseImage(id: "")
    }
}
