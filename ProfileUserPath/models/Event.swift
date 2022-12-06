import Foundation

struct Event: Identifiable, Codable {
    enum EventType: String, Identifiable, CaseIterable, Codable {
        case work, home, social, sport, unspecified
        var id: String {
            self.rawValue
        }

        var icon: String {
            switch self {
            case .work:
                return "🏦"
            case .home:
                return "🏡"
            case .social:
                return "🎉"
            case .sport:
                return "🏟"
            case .unspecified:
                return "📌"
            }
        }
    }

    var eventType: EventType
    var date: Date
    var note: String
    var id: String
    var uid: String
    
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents(
            [.month, .day, .year, .hour, .minute], from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }

    init(id: String = UUID().uuidString, eventType: EventType = .unspecified, date: Date, note: String, uid: String) {
        self.eventType = eventType
        self.date = date
        self.note = note
        self.id = id
        self.uid = uid
    }

    // Data to be used in the preview
    static var sampleEvents: [Event] {
        return [
            Event(eventType: .home, date: Date().diff(numDays: 0), note: "Take dog to groomers", uid: "1111"),
            Event(date: Date().diff(numDays: -1), note: "Get gift for Emily", uid: "1111"),
            Event(eventType: .home, date: Date().diff(numDays: 6), note: "File tax returns.", uid: "1111"),
            Event(eventType: .social, date: Date().diff(numDays: 2), note: "Dinner party at Dave and Janet's", uid: "1111"),
            Event(eventType: .work, date: Date().diff(numDays: -1), note: "Complete Audit.", uid: "1111"),
            Event(eventType: .sport, date: Date().diff(numDays: -3), note: "Football Game", uid: "1111"),
            Event(date: Date().diff(numDays: -4), note: "Plan for winter vacation.", uid: "1111")
        ]
    }
}
