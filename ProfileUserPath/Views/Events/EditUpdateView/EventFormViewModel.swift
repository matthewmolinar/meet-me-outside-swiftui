//
//  EventFormViewModel.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/4/22.
//

import SwiftUI
import Firebase

class EventFormViewModel: ObservableObject {
    @Published var date = Date()
    @Published var note = ""
    @Published var eventType: Event.EventType = .unspecified

    var id: String?
    var updating: Bool { id != nil }

    init() {}

    init(_ event: Event) {
        date = event.date
        note = event.note
        eventType = event.eventType
        id = event.id
    }

    var incomplete: Bool {
        note.isEmpty
    }
    
    func uploadEvent(date: Date, note: String) {
        guard let user = AuthViewModel.shared.user else { return }
        let docRef = Firestore.firestore().collection("events").document()
        
        let data: [String: Any] = [
            "uid": user.id, "date": "TEST", "note": note
        ]
        
        docRef.setData(data) { _ in
            print("DEBUG: uploaded event")
        }
        
    }
}
