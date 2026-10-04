import Foundation
import Observation

@MainActor
@Observable
final class PlanStore {
    private(set) var state: PlanState

    private let calendar: Calendar

    var visibleDates: [Date] {
        DateWindow.weekDates(around: state.windowAnchorDate, calendar: calendar)
    }

    init(now: Date = .now, calendar: Calendar = .current) {
        self.calendar = calendar
        let today = calendar.startOfDay(for: now)
        state = PlanState(selectedDate: today, windowAnchorDate: today)
    }

    func send(_ action: PlanAction) {
        switch action {
        case let .selectDate(date):
            select(date)
        }
    }

    private func select(_ date: Date) {
        let selectedDate = calendar.startOfDay(for: date)
        state.selectedDate = selectedDate

        guard !visibleDates.contains(where: { calendar.isDate($0, inSameDayAs: selectedDate) }) else {
            return
        }

        state.windowAnchorDate = selectedDate
    }
}
