//
//  Date+Extension.swift
//  ProfileUserPath
//
//  Created by Matthew Molinar on 12/4/22.
//

import Foundation

extension Date {
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    // when u compare two dates it always compares the starts of dates
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
