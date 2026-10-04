import XCTest
@testable import Moha

@MainActor
final class PlanStoreTests: XCTestCase {
    func testInitialStateSelectsTodayInProvidedTimeZone() {
        let calendar = makeCalendar(in: "Asia/Seoul")
        let utcCalendar = makeCalendar(in: "UTC")
        let now = makeDate(2026, 7, 30, hour: 15, calendar: utcCalendar)
        let store = PlanStore(now: now, calendar: calendar)

        XCTAssertEqual(dayComponents(store.state.selectedDate, calendar: calendar), [2026, 7, 31])
        XCTAssertEqual(dayComponents(store.state.windowAnchorDate, calendar: calendar), [2026, 7, 31])
        XCTAssertEqual(store.visibleDates.count, 21)
        XCTAssertTrue(store.visibleDates.contains { calendar.isDate($0, inSameDayAs: now) })
    }

    func testSelectingDateWithinWindowPreservesWindowAnchor() {
        let calendar = makeCalendar(in: "Asia/Seoul")
        let today = makeDate(2026, 7, 31, calendar: calendar)
        let selectedDate = makeDate(2026, 7, 27, calendar: calendar)
        let store = PlanStore(now: today, calendar: calendar)

        store.send(.selectDate(selectedDate))

        XCTAssertEqual(dayComponents(store.state.selectedDate, calendar: calendar), [2026, 7, 27])
        XCTAssertEqual(dayComponents(store.state.windowAnchorDate, calendar: calendar), [2026, 7, 31])
    }

    func testSelectingDateOutsideWindowRecentersOnItsWeek() {
        let calendar = makeCalendar(in: "Asia/Seoul")
        let today = makeDate(2026, 7, 31, calendar: calendar)
        let selectedDate = makeDate(2026, 8, 31, calendar: calendar)
        let store = PlanStore(now: today, calendar: calendar)

        store.send(.selectDate(selectedDate))

        XCTAssertEqual(dayComponents(store.state.selectedDate, calendar: calendar), [2026, 8, 31])
        XCTAssertEqual(dayComponents(store.state.windowAnchorDate, calendar: calendar), [2026, 8, 31])
        XCTAssertEqual(dayComponents(store.visibleDates.first!, calendar: calendar), [2026, 8, 24])
        XCTAssertTrue(store.visibleDates.contains { calendar.isDate($0, inSameDayAs: selectedDate) })
    }

    private func makeCalendar(in timeZoneID: String) -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: timeZoneID)!
        return calendar
    }

    private func makeDate(
        _ year: Int,
        _ month: Int,
        _ day: Int,
        hour: Int = 0,
        calendar: Calendar
    ) -> Date {
        calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour))!
    }

    private func dayComponents(_ date: Date, calendar: Calendar) -> [Int] {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return [components.year!, components.month!, components.day!]
    }
}
