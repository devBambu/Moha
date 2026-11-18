import Foundation

enum DateTestSupport {
    static func calendar(in timeZoneID: String, firstWeekday: Int = 1) -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: timeZoneID)!
        calendar.firstWeekday = firstWeekday
        return calendar
    }

    static func date(
        year: Int,
        month: Int,
        day: Int,
        hour: Int = 0,
        calendar: Calendar = .current
    ) -> Date {
        calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour))!
    }

    static func dayComponents(_ date: Date, calendar: Calendar) -> [Int] {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return [components.year!, components.month!, components.day!]
    }
}
