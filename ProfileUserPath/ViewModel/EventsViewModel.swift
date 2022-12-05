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
        fetchEvents() {
            return nil
≈        }
    }
    
    func fetchEvents() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = Firestore.firestore().collection("events")
        
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges else { return}
            
            changes.forEach { change in
                let data = change.document.data()
                self.events.append(Event(dictionary: data))
            }
        }
        
    }
}
