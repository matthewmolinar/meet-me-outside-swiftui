import SwiftUI
import Firebase


class ProfileViewModel: ObservableObject {
    let user: User
    @Published var userEvents = [Event]()
    
    init(user: User) {
        self.user = user
        fetchUserEvents()
    }
    
    func fetchUserEvents() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("events").whereField("uid", isEqualTo: user.id).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching snapshot documents: \(error?.localizedDescription)")
                return
            }
            var newEventsArray = [Event]()
            for document in documents {
                print("DEBUG: \(document.data())")
                let timeStamp = document.data()["date"] as! Timestamp
                let date = Date(timeIntervalSince1970: TimeInterval(timeStamp.seconds))
                let eventId = document.data()["id"] as! String
                print("DEBUG: \(date)")
                let note = document.data()["note"] as! String
                // make event object
                let eventObject = Event(id: eventId, date: date, note: note, uid: self.user.id)
                newEventsArray.append(eventObject)
            }
            self.userEvents = newEventsArray
        }
    }
}
