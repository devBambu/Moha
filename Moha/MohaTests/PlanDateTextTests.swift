import XCTest
@testable import Moha

final class PlanDateTextTests: XCTestCase {
    func testKoreanDateLabels() {
        let date = DateTestSupport.date(year: 2026, month: 7, day: 31, hour: 12)
        let locale = Locale(identifier: "ko_KR")

        XCTAssertEqual(PlanDateText.weekday(for: date, locale: locale), "금")
        XCTAssertEqual(PlanDateText.selectedDate(for: date, locale: locale), "7월 31일 금요일")
        XCTAssertEqual(PlanDateText.yearMonth(for: date, locale: locale), "2026년 7월")

        let nextYear = DateTestSupport.date(year: 2027, month: 1, day: 1, hour: 12)
        XCTAssertEqual(PlanDateText.selectedDate(for: nextYear, locale: locale), "1월 1일 금요일")
        XCTAssertEqual(PlanDateText.yearMonth(for: nextYear, locale: locale), "2027년 1월")
    }

    func testEnglishDateLabelsFollowLocale() {
        let date = DateTestSupport.date(year: 2026, month: 7, day: 31, hour: 12)
        let locale = Locale(identifier: "en_US")

        XCTAssertEqual(PlanDateText.weekday(for: date, locale: locale), "FRI")
        XCTAssertEqual(PlanDateText.selectedDate(for: date, locale: locale), "Fri, Jul 31")
        XCTAssertEqual(PlanDateText.yearMonth(for: date, locale: locale), "July 2026")
    }
}
