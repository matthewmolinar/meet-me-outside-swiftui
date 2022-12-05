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
    @Binding var displayEvents: Bool
    @Binding var dateSelected: DateComponents? 
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        if let changedEvent = eventStore.changedEvent {
            uiView.reloadDecorations(forDateComponents: [changedEvent.dateComponents], animated: true)
            eventStore.changedEvent = nil
        }

        if let movedEvent = eventStore.movedEvent {
            uiView.reloadDecorations(forDateComponents: [movedEvent.dateComponents], animated: true)
            eventStore.movedEvent = nil
        }
        
        
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.dateSelected = dateComponents
            guard let dateComponents else { return }
            
            let currentEvents = eventStore.events
                .filter { $0.date.startOfDay == dateComponents.date?.startOfDay }
            if !currentEvents.isEmpty {
                parent.displayEvents.toggle()
            }
            
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
            // just lets us know if we can select this date or not, setting to true.
            return true
        }
        
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
            
            
            
            // determine if there are any events in the store for a date
            let currentEvents = eventStore.events
                .filter { $0.date.startOfDay == dateComponents.date?.startOfDay }
            if currentEvents.isEmpty { return nil }
            
            if currentEvents.count > 1 {
                return .image(UIImage(systemName: "doc.on.doc.fill"), color: .red, size: .large)
            }
            
            let singleEvent = currentEvents.first!
            return .customView {
                let icon = UILabel()
                icon.text = singleEvent.eventType.icon
                return icon
            }
        }
        
        
    }
    
    
    
    
    
    
}
