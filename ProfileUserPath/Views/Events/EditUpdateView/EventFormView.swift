//
//  EventFormView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/4/22.
//
import Foundation
import SwiftUI
import Firebase
import ConfettiSwiftUI


struct EventFormView: View {
    @EnvironmentObject var eventStore: EventStore
    @StateObject var viewModel: EventFormViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    @State private var counter: Int = 0
    
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
                            if viewModel.updating {
                                
                                guard let uid = AuthViewModel.shared.userSession?.uid else { return }
                                
                                let docRef = Firestore.firestore().collection("events").document(viewModel.id!)
                                print("DEBUG:  update id - \(viewModel.id!)")

                                print("DEBUG:  update Note - \(viewModel.note)")
                                print("DEBUG:  update Date - \(viewModel.date)")

                                docRef.updateData([
                                    "date": viewModel.date, "note": viewModel.note
                                ])
                                print("DEBUG: Updated Event")
                                
                            } else {
                                // create new event
                                guard let user = AuthViewModel.shared.user else { return }


                                let idString = UUID().uuidString
                                let docRef = Firestore.firestore().collection("events").document(idString)
                                
                                let data: [String: Any] = [
                                    "uid": user.id, "date": viewModel.date, "note": viewModel.note, "id": idString
                                ]
                                
                                docRef.setData(data) { _ in
                                    counter += 1
                                    print("DEBUG: uploaded event")
                                }
                            }
//                            dismiss()
                        } label: {
                            Text(viewModel.updating ? "Update Event" : "Add Event")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.incomplete)
                        .confettiCannon(counter: $counter)

                        Spacer()
                    }
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle(viewModel.updating ? "Edit Event" : "New Event")
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
