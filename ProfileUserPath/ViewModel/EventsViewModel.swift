//
//  EventsViewModel.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/4/22.
//

import SwiftUI
import Firebase

class EventsViewModel: ObservableObject {
    @Published var events = [Event]()
    
    init() {
        fetchEvents()
    }
    
    func fetchEvents() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("events")
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges else { return}
            
            changes.forEach { change in
                let data = change.document.data()
                // construct an Event object
                if let date = change.document.data()["date"] as? Date {
                    if let note = change.document.data()["note"] as? String {
                        if let eventId = change.document.data()["id"] as? String {
                            self.events.append(Event(id: eventId, date: date, note: note, uid: uid))
                        }
                    }
                }
            }
        }
        
    }
}
