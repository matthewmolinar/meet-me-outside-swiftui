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
}
