//
//  CalendarView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/4/22.
//

import SwiftUI


struct CalendarView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, eventStore: _eventStore)
    }
    
    let interval: DateInterval
    @ObservedObject var eventStore: EventStore
    
    func makeUIView(context: Context) -> UICalendarView {
         let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
         
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate {
        // communicating between the calendar view and the coordinator
        var parent: CalendarView
        @ObservedObject var eventStore: EventStore
        init(parent: CalendarView, eventStore: ObservedObject<EventStore>) {
            self.parent = parent
            self._eventStore = eventStore
        }
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            // this is what is used to create the icons or display particular events, its from UIKit so needs to be on Main thread, thats why @MainActor
            return nil
        }
        
        
    }
    
    
    
    
    
    
}
