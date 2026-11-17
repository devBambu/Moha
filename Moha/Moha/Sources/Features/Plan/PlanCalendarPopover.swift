import SwiftUI

struct PlanCalendarPopover: View {
    @Environment(\.calendar) private var calendar

    let selectedDate: Date
    let onSelect: (Date) -> Void
    let onSelectToday: () -> Void

    private var dateSelection: Binding<Set<DateComponents>> {
        let selectedComponents = calendar.dateComponents([.era, .year, .month, .day], from: selectedDate)

        return Binding(
            get: { [selectedComponents] },
            set: { dates in
                guard let selectedComponents = dates.first(where: { components in
                    guard let date = calendar.date(from: components) else {
                        return false
                    }

                    return !calendar.isDate(date, inSameDayAs: selectedDate)
                }) else {
                    if dates.isEmpty {
                        onSelect(selectedDate)
                    }
                    return
                }

                guard let date = calendar.date(from: selectedComponents) else {
                    return
                }

                onSelect(date)
            }
        )
    }

    var body: some View {
        VStack(spacing: 12) {
            MultiDatePicker(selection: dateSelection) {
                EmptyView()
            }
            .labelsHidden()

            Divider()

            Button("PlanView.todayMove", action: onSelectToday)
        }
        .padding(.horizontal, 20) // VStack 전체 바깥의 여백
        .padding(.bottom, 20)
    }
}
