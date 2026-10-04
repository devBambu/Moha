import Foundation

enum DateWindow {
    static func weekDates(
        around date: Date,
        weeksBefore: Int,
        weeksAfter: Int,
        calendar: Calendar
    ) -> [Date] {
        var calendar = calendar
        calendar.firstWeekday = 2

        let currentWeekMonday = calendar.dateInterval(of: .weekOfYear, for: date)!.start
        let firstDate = calendar.startOfDay(
            for: calendar.date(byAdding: .weekOfYear, value: -weeksBefore, to: currentWeekMonday)!
        )
        let weekCount = weeksBefore + weeksAfter + 1

        return (0..<(weekCount * 7)).map { offset in
            calendar.date(byAdding: .day, value: offset, to: firstDate)!
        }
    }
}
