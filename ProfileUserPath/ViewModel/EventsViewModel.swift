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
                if let eventType = change.document.data()["eventType"] as? String {
                    if let date = change.document.data()["date"] as? Date {
                        if let note = change.document.data()["note"] as? String {
                            if let id = change.document.data()["id"] as? String {
                                let eventObject = Event(date: date, note: note)
                                
                            }
                        }
                    }
                }
//                self.events.append(Event(dictionary: data))
            }
        }
        
    }
}
