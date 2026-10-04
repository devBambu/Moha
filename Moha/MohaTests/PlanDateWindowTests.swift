import XCTest
@testable import Moha

final class PlanDateWindowTests: XCTestCase {
    func testWindowCrossesMonthAndYearWithMondayStart() {
        let calendar = calendar(in: "Asia/Seoul")
        let date = makeDate(2026, 1, 1, calendar: calendar)

        let dates = PlanDateWindow.dates(around: date, calendar: calendar)

        XCTAssertEqual(dates.count, 21)
        XCTAssertEqual(dayComponents(dates.first!, calendar: calendar), [2025, 12, 22])
        XCTAssertEqual(dayComponents(dates[7], calendar: calendar), [2025, 12, 29])
        XCTAssertEqual(dayComponents(dates.last!, calendar: calendar), [2026, 1, 11])
        XCTAssertEqual(calendar.component(.weekday, from: dates.first!), 2)
    }

    func testSameInstantUsesSuppliedTimeZone() {
        let seoul = calendar(in: "Asia/Seoul")
        let losAngeles = calendar(in: "America/Los_Angeles")
        let instant = makeDate(2026, 1, 5, calendar: seoul)

        let seoulDates = PlanDateWindow.dates(around: instant, calendar: seoul)
        let losAngelesDates = PlanDateWindow.dates(around: instant, calendar: losAngeles)

        XCTAssertEqual(dayComponents(seoulDates.first!, calendar: seoul), [2025, 12, 29])
        XCTAssertEqual(dayComponents(losAngelesDates.first!, calendar: losAngeles), [2025, 12, 22])
    }

    func testDaysRemainConsecutiveAcrossDaylightSavingChange() {
        let calendar = calendar(in: "America/Los_Angeles")
        let date = makeDate(2026, 3, 8, calendar: calendar)

        let dates = PlanDateWindow.dates(around: date, calendar: calendar)

        XCTAssertEqual(dates.count, 21)
        for (current, next) in zip(dates, dates.dropFirst()) {
            XCTAssertEqual(calendar.dateComponents([.day], from: current, to: next).day, 1)
        }
        XCTAssertEqual(dayComponents(dates.first!, calendar: calendar), [2026, 2, 23])
        XCTAssertEqual(dayComponents(dates.last!, calendar: calendar), [2026, 3, 15])
    }

    private func calendar(in timeZoneID: String) -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: timeZoneID)!
        calendar.firstWeekday = 1
        return calendar
    }

    private func makeDate(_ year: Int, _ month: Int, _ day: Int, calendar: Calendar) -> Date {
        calendar.date(from: DateComponents(year: year, month: month, day: day))!
    }

    private func dayComponents(_ date: Date, calendar: Calendar) -> [Int] {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return [components.year!, components.month!, components.day!]
    }
}
