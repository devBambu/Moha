import XCTest
@testable import Moha

@MainActor
final class PlanStoreTests: XCTestCase {
    func testInitialStateSelectsTodayInProvidedTimeZone() {
        let calendar = DateTestSupport.calendar(in: "Asia/Seoul")
        let utcCalendar = DateTestSupport.calendar(in: "UTC")
        let now = DateTestSupport.date(year: 2026, month: 7, day: 30, hour: 15, calendar: utcCalendar)
        let store = PlanStore(now: now, calendar: calendar)

        XCTAssertEqual(DateTestSupport.dayComponents(store.state.selectedDate, calendar: calendar), [2026, 7, 31])
        XCTAssertEqual(DateTestSupport.dayComponents(store.state.today, calendar: calendar), [2026, 7, 31])
        XCTAssertEqual(DateTestSupport.dayComponents(store.state.windowAnchorDate, calendar: calendar), [2026, 7, 31])
        XCTAssertEqual(store.visibleDates.count, 21)
        XCTAssertTrue(store.visibleDates.contains { calendar.isDate($0, inSameDayAs: now) })
    }

    func testSelectingDateWithinWindowPreservesWindowAnchor() {
        let calendar = DateTestSupport.calendar(in: "Asia/Seoul")
        let today = DateTestSupport.date(year: 2026, month: 7, day: 31, calendar: calendar)
        let selectedDate = DateTestSupport.date(year: 2026, month: 7, day: 27, calendar: calendar)
        let store = PlanStore(now: today, calendar: calendar)

        store.send(.selectDate(selectedDate))

        XCTAssertEqual(DateTestSupport.dayComponents(store.state.selectedDate, calendar: calendar), [2026, 7, 27])
        XCTAssertEqual(DateTestSupport.dayComponents(store.state.windowAnchorDate, calendar: calendar), [2026, 7, 31])
    }

    func testSelectingDateOutsideWindowRecentersOnItsWeek() {
        let calendar = DateTestSupport.calendar(in: "Asia/Seoul")
        let today = DateTestSupport.date(year: 2026, month: 7, day: 31, calendar: calendar)
        let selectedDate = DateTestSupport.date(year: 2026, month: 8, day: 31, calendar: calendar)
        let store = PlanStore(now: today, calendar: calendar)

        store.send(.selectDate(selectedDate))

        XCTAssertEqual(DateTestSupport.dayComponents(store.state.selectedDate, calendar: calendar), [2026, 8, 31])
        XCTAssertEqual(DateTestSupport.dayComponents(store.state.windowAnchorDate, calendar: calendar), [2026, 8, 31])
        XCTAssertEqual(DateTestSupport.dayComponents(store.visibleDates.first!, calendar: calendar), [2026, 8, 24])
        XCTAssertTrue(store.visibleDates.contains { calendar.isDate($0, inSameDayAs: selectedDate) })
    }

    func testSelectTodaySelectsTodayAndKeepsWindowWhenTodayIsVisible() {
        let calendar = DateTestSupport.calendar(in: "Asia/Seoul")
        let today = DateTestSupport.date(year: 2026, month: 7, day: 31, calendar: calendar)
        let selectedDate = DateTestSupport.date(year: 2026, month: 7, day: 27, calendar: calendar)
        let store = PlanStore(now: today, calendar: calendar)
        store.send(.selectDate(selectedDate))

        store.send(.selectToday)

        XCTAssertEqual(DateTestSupport.dayComponents(store.state.selectedDate, calendar: calendar), [2026, 7, 31])
        XCTAssertEqual(DateTestSupport.dayComponents(store.state.windowAnchorDate, calendar: calendar), [2026, 7, 31])
    }

    func testSelectTodayRecentersWindowWhenTodayIsOutsideVisibleRange() {
        let calendar = DateTestSupport.calendar(in: "Asia/Seoul")
        let today = DateTestSupport.date(year: 2026, month: 7, day: 31, calendar: calendar)
        let distantDate = DateTestSupport.date(year: 2026, month: 8, day: 31, calendar: calendar)
        let store = PlanStore(now: today, calendar: calendar)
        store.send(.selectDate(distantDate))

        store.send(.selectToday)

        XCTAssertEqual(DateTestSupport.dayComponents(store.state.selectedDate, calendar: calendar), [2026, 7, 31])
        XCTAssertEqual(DateTestSupport.dayComponents(store.state.windowAnchorDate, calendar: calendar), [2026, 7, 31])
        XCTAssertTrue(store.visibleDates.contains { calendar.isDate($0, inSameDayAs: today) })
    }

    func testAppBecameActiveUpdatesTodayAndKeepsSelectionAndWindow() {
        let calendar = DateTestSupport.calendar(in: "Asia/Seoul")
        let today = DateTestSupport.date(year: 2026, month: 7, day: 31, calendar: calendar)
        let selectedDate = DateTestSupport.date(year: 2026, month: 7, day: 27, calendar: calendar)
        let nextDay = DateTestSupport.date(year: 2026, month: 8, day: 1, hour: 10, calendar: calendar)
        let store = PlanStore(now: today, calendar: calendar)
        store.send(.selectDate(selectedDate))

        store.send(.appBecameActive(now: nextDay))

        XCTAssertEqual(DateTestSupport.dayComponents(store.state.today, calendar: calendar), [2026, 8, 1])
        XCTAssertEqual(DateTestSupport.dayComponents(store.state.selectedDate, calendar: calendar), [2026, 7, 27])
        XCTAssertEqual(DateTestSupport.dayComponents(store.state.windowAnchorDate, calendar: calendar), [2026, 7, 31])
        XCTAssertFalse(store.isSelectedDateToday)
    }
}
