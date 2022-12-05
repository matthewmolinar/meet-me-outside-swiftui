//
//  EventStore.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/4/22.
//


import Foundation
import Firebase

@MainActor
class EventStore: ObservableObject {
    @Published var events = [Event]()
    @Published var preview: Bool
    @Published var changedEvent: Event?
    @Published var movedEvent: Event?

    init(preview: Bool = false) {
        self.preview = preview
//        fetchEvents()
        fetchEventsSnapShotListener()
    }

    func fetchEvents() {
        if preview {
            events = Event.sampleEvents
        } else {
            guard let uid = AuthViewModel.shared.userSession?.uid else { return }
            print("DEBUG: uid: \(uid)")
            
            let query = Firestore.firestore().collection("events").whereField("uid", isEqualTo: uid).getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                for document in documents {
                    print("DEBUG: \(document.data())")
                    let timeStamp = document.data()["date"] as! Timestamp
                    let date = Date(timeIntervalSince1970: TimeInterval(timeStamp.seconds))
                    let eventId = document.data()["id"] as! String
                    print("DEBUG: \(date)")
                    let note = document.data()["note"] as! String
                    // make event object
                    let eventObject = Event(id: eventId, date: date, note: note, uid: uid)
                    self.events.append(eventObject)
                }
            }
        }
    }
    
    func fetchEventsSnapShotListener() {
        if preview {
            events = Event.sampleEvents
        } else {
            guard let uid = AuthViewModel.shared.userSession?.uid else { return }
            
            Firestore.firestore().collection("events").whereField("uid", isEqualTo: uid).addSnapshotListener { querySnapshot, error in
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
                    let eventObject = Event(id: eventId, date: date, note: note, uid: uid)
                    newEventsArray.append(eventObject)
                }
                self.events = newEventsArray
                
            }
        }
    }

    func delete(_ event: Event) {
        if let index = events.firstIndex(where: {$0.id == event.id}) {
            changedEvent = events.remove(at: index)
        }
    }

    func add(_ event: Event) {
        events.append(event)
        changedEvent = event
    }

    func update(_ eventId: String) {
        return
    }

}
