import Foundation

enum PlanDateText {
    static func selectedDate(for date: Date, locale: Locale) -> String {
        if locale.language.languageCode?.identifier == "ko" {
            return date.formatted(
                Date.FormatStyle.dateTime
                    .locale(locale)
                    .month(.abbreviated)
                    .day()
                    .weekday(.wide)
            )
        }

        return date.formatted(
            Date.FormatStyle.dateTime
                .locale(locale)
                .month(.abbreviated)
                .day()
                .weekday(.abbreviated)
        )
    }

    static func yearMonth(for date: Date, locale: Locale) -> String {
        date.formatted(
            Date.FormatStyle.dateTime
                .locale(locale)
                .year()
                .month(.wide)
        )
    }
}
