import Foundation

enum PlanDateWindow {
    static func dates(around date: Date, calendar: Calendar) -> [Date] {
        var calendar = calendar
        calendar.firstWeekday = 2

        let monday = calendar.dateInterval(of: .weekOfYear, for: date)!.start
        let firstDate = calendar.date(byAdding: .day, value: -7, to: monday)!

        return (0..<21).map { offset in
            calendar.date(byAdding: .day, value: offset, to: firstDate)!
        }
    }
}
