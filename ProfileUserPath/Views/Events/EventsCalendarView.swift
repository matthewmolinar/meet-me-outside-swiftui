//
//  EventsCalendarView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/4/22.
//

import SwiftUI

struct EventsCalendarView: View {
    @EnvironmentObject var eventStore: EventStore
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture), eventStore: eventStore)
                
            }
                    .navigationTitle("Calendar")
            
            
        }
    }
}

struct EventsCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        EventsCalendarView()
            .environmentObject(EventStore(preview: true))
    }
}
