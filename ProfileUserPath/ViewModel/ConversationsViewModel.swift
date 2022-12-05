//  Created by Matthew Molinar on 11/29/22.
//

import SwiftUI
import Firebase

class ConversationsViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    private var recentMessagesDictionary = [String: Message]()
    
    
    init() {
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = Firestore.firestore().collection("messages").document(uid).collection("recent-messages")
        query.order(by: "timestamp", descending: true)
        
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges else { return }
            
            changes.forEach { change in
                let messageData = change.document.data()
                let uid = change.document.documentID
                
                
                
                Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    self.recentMessagesDictionary[uid] = Message(user: user, dictionary: messageData)
                    self.recentMessages = Array(self.recentMessagesDictionary.values)
                }
            }
        }
    }
}
