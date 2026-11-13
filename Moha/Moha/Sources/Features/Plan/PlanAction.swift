import Foundation

enum PlanAction {
    case selectDate(Date)
    case selectToday
    case appBecameActive(now: Date)
}
