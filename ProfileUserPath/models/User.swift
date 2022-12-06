import Foundation
import Firebase

struct User: Identifiable {
    let id: String
    let name: String
    let age: String
    let grade: String
    let profilePictureUrl: String
    let profileDescription: String
    let username: String
    let isCurrentUser: Bool
    
    
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.age = dictionary["age"] as? String ?? ""
        self.grade = dictionary["grade"] as? String ?? ""
        self.profilePictureUrl = dictionary["profilePictureUrl"] as? String ?? ""
        self.profileDescription = dictionary["profileDescription"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.isCurrentUser = Auth.auth().currentUser?.uid == self.id
     }
}
