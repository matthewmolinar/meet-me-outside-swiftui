//
//  EventFormView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/4/22.
//
import Foundation
import SwiftUI
import Firebase

struct EventFormView: View {
    @EnvironmentObject var eventStore: EventStore
    @StateObject var viewModel: EventFormViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    DatePicker(selection: $viewModel.date) {
                        Text("Date and Time")
                    }
                    TextField("Note", text: $viewModel.note, axis: .vertical)
                        .focused($focus, equals: true)
                    Picker("Event Type", selection: $viewModel.eventType) {
                        ForEach(Event.EventType.allCases) {eventType in
                            Text(eventType.icon + " " + eventType.rawValue.capitalized)
                                .tag(eventType)
                        }
                    }
                    Section(footer:
                                HStack {
                        Spacer()
                        Button {
                            // UPDATE FIREBASE HERE!!!!
                            if viewModel.updating {
                                // update this event
                                let event = Event(id: viewModel.id!,
                                                  eventType: viewModel.eventType,
                                                  date: viewModel.date,
                                                  note: viewModel.note)
                                // ENCODE
//                                let jsonEncoder = JSONEncoder()
//                                do {
//                                    let encodedEvent = try jsonEncoder.encode(event)
//                                    let encodedStringEvent = String(data: encodedEvent, encoding: .utf8)!
//                                    // push update to firebase.
//
//                                } catch {
//                                    print(error.localizedDescription)
//                                }
                                
//                                viewModel.uploadEvent(date: viewModel.date, note: viewModel.note)
                                // might not need this anymore.
                                eventStore.update(event)
                            } else {
                                // create new event
                                guard let user = AuthViewModel.shared.user else { return }

                                let newEvent = Event(eventType: viewModel.eventType,
                                                     date: viewModel.date,
                                                     note: viewModel.note)
                                let docRef = Firestore.firestore().collection("events").document()
                                
                                let data: [String: Any] = [
                                    "uid": user.id, "date": viewModel.date, "note": viewModel.note
                                ]
                                
                                docRef.setData(data) { _ in
                                    print("DEBUG: uploaded event")
                                }
                            }
                            dismiss()
                        } label: {
                            Text(viewModel.updating ? "Update Event" : "Add Event")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.incomplete)
                        Spacer()
                    }
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle(viewModel.updating ? "Update" : "New Event")
            .onAppear {
                focus = true
            }
        }
    }
}

struct EventFormView_Previews: PreviewProvider {
    static var previews: some View {
        EventFormView(viewModel: EventFormViewModel())
            .environmentObject(EventStore())
    }
}
