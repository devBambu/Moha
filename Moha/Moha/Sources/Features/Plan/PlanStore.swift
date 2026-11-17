import Foundation
import Observation

@MainActor
@Observable
final class PlanStore {
    private(set) var state: PlanState

    private var calendar: Calendar

    var visibleDates: [Date] {
        DateWindow.weekDates(around: state.windowAnchorDate, calendar: calendar)
    }

    var isSelectedDateToday: Bool {
        calendar.isDate(state.selectedDate, inSameDayAs: state.today)
    }

    init(now: Date = .now, calendar: Calendar = .current) {
        self.calendar = calendar
        let today = calendar.startOfDay(for: now)
        state = PlanState(today: today, selectedDate: today, windowAnchorDate: today)
    }

    func send(_ action: PlanAction) {
        switch action {
        case let .selectDate(date):
            select(date)
        case .selectToday:
            select(state.today)
        case let .appBecameActive(now, calendar):
            self.calendar = calendar
            state.today = calendar.startOfDay(for: now)
        }
    }
}

extension PlanStore {
    private func select(_ date: Date) {
        let selectedDate = calendar.startOfDay(for: date)
        state.selectedDate = selectedDate

        guard !visibleDates.contains(where: { calendar.isDate($0, inSameDayAs: selectedDate) }) else {
            return
        }

        state.windowAnchorDate = selectedDate
    }
}
