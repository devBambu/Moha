import XCTest
@testable import Moha

final class PlanDateTextTests: XCTestCase {
    func testKoreanDateLabels() {
        let date = makeDate(2026, 7, 31)
        let locale = Locale(identifier: "ko_KR")

        XCTAssertEqual(PlanDateText.selectedDate(for: date, locale: locale), "7월 31일 금요일")
        XCTAssertEqual(PlanDateText.yearMonth(for: date, locale: locale), "2026년 7월")

        let nextYear = makeDate(2027, 1, 1)
        XCTAssertEqual(PlanDateText.selectedDate(for: nextYear, locale: locale), "1월 1일 금요일")
        XCTAssertEqual(PlanDateText.yearMonth(for: nextYear, locale: locale), "2027년 1월")
    }

    func testEnglishDateLabelsFollowLocale() {
        let date = makeDate(2026, 7, 31)
        let locale = Locale(identifier: "en_US")

        XCTAssertEqual(PlanDateText.selectedDate(for: date, locale: locale), "Fri, Jul 31")
        XCTAssertEqual(PlanDateText.yearMonth(for: date, locale: locale), "July 2026")
    }

    private func makeDate(_ year: Int, _ month: Int, _ day: Int) -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        return calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 12))!
    }
}
