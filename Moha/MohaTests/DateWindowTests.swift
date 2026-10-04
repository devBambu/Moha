import XCTest
@testable import Moha

final class DateWindowTests: XCTestCase {
    func testWindowCrossesMonthAndYearWithMondayStart() {
        let calendar = DateTestSupport.calendar(in: "Asia/Seoul")
        let date = DateTestSupport.date(year: 2026, month: 1, day: 1, calendar: calendar)

        let dates = DateWindow.weekDates(
            around: date,
            weeksBefore: 1,
            weeksAfter: 1,
            calendar: calendar
        )

        XCTAssertEqual(dates.count, 21)
        XCTAssertEqual(DateTestSupport.dayComponents(dates.first!, calendar: calendar), [2025, 12, 22])
        XCTAssertEqual(DateTestSupport.dayComponents(dates[7], calendar: calendar), [2025, 12, 29])
        XCTAssertEqual(DateTestSupport.dayComponents(dates.last!, calendar: calendar), [2026, 1, 11])
        XCTAssertEqual(calendar.component(.weekday, from: dates.first!), 2)
    }

    func testSingleWeekWindowCanBeRequested() {
        let calendar = DateTestSupport.calendar(in: "Asia/Seoul")
        let date = DateTestSupport.date(year: 2026, month: 7, day: 31, calendar: calendar)

        let dates = DateWindow.weekDates(
            around: date,
            weeksBefore: 0,
            weeksAfter: 0,
            calendar: calendar
        )

        XCTAssertEqual(dates.count, 7)
        XCTAssertEqual(DateTestSupport.dayComponents(dates.first!, calendar: calendar), [2026, 7, 27])
        XCTAssertEqual(DateTestSupport.dayComponents(dates.last!, calendar: calendar), [2026, 8, 2])
    }

    func testSameInstantUsesSuppliedTimeZone() {
        let seoul = DateTestSupport.calendar(in: "Asia/Seoul")
        let losAngeles = DateTestSupport.calendar(in: "America/Los_Angeles")
        let instant = DateTestSupport.date(year: 2026, month: 1, day: 5, calendar: seoul)

        let seoulDates = DateWindow.weekDates(
            around: instant,
            weeksBefore: 1,
            weeksAfter: 1,
            calendar: seoul
        )
        let losAngelesDates = DateWindow.weekDates(
            around: instant,
            weeksBefore: 1,
            weeksAfter: 1,
            calendar: losAngeles
        )

        XCTAssertEqual(DateTestSupport.dayComponents(seoulDates.first!, calendar: seoul), [2025, 12, 29])
        XCTAssertEqual(DateTestSupport.dayComponents(losAngelesDates.first!, calendar: losAngeles), [2025, 12, 22])
    }

    func testDaysRemainConsecutiveAcrossDaylightSavingChange() {
        let calendar = DateTestSupport.calendar(in: "America/Los_Angeles")
        let date = DateTestSupport.date(year: 2026, month: 3, day: 8, calendar: calendar)

        let dates = DateWindow.weekDates(
            around: date,
            weeksBefore: 1,
            weeksAfter: 1,
            calendar: calendar
        )

        XCTAssertEqual(dates.count, 21)
        for (current, next) in zip(dates, dates.dropFirst()) {
            XCTAssertEqual(calendar.dateComponents([.day], from: current, to: next).day, 1)
        }
        XCTAssertEqual(DateTestSupport.dayComponents(dates.first!, calendar: calendar), [2026, 2, 23])
        XCTAssertEqual(DateTestSupport.dayComponents(dates.last!, calendar: calendar), [2026, 3, 15])
    }
}
