import SwiftUI

struct PlanCalendarPopover: View {
    let selectedDate: Date
    let onSelect: (Date) -> Void
    let onSelectToday: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            DatePicker(
                "",
                selection: Binding(
                    get: { selectedDate },
                    set: onSelect
                ),
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .labelsHidden()

            Divider()

            Button("PlanView.todayMove", action: onSelectToday)
        }
        .padding()
    }
}
