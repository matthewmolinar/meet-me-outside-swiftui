import Foundation
import UIKit
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    var completion: (_ image: UIImage?) -> Void
    typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> CameraView.Coordinator {
        return Coordinator(self, completion: self.completion)
    }
}

extension CameraView {
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var completion: (_ image: UIImage?) -> Void
        var parent: CameraView
        
        init(_ parent: CameraView, completion: @escaping ((_ image: UIImage?) -> Void)) {
            self.parent = parent
            self.completion = completion
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("Cancel pressed")
            self.completion(nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.completion(image)
            }
        }
    }
}
