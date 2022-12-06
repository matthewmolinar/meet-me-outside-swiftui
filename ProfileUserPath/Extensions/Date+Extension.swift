import Foundation

extension Date {
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    // when you compare two dates it always compares the starts of dates
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
