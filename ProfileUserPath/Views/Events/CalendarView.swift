//
//  CalendarView.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/4/22.
//

import SwiftUI


struct CalendarView: UIViewRepresentable {
    let interval: DateInterval
    
    func makeUIView(context: Context) -> UICalendarView {
         let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
         
    }
    
    
    
    
    
    
}
