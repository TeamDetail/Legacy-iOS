import SwiftUI

public enum LegacyMenuItem: Int, CaseIterable {
    case arrow, calendar, people, mail, setting, wrong, logout
    
    var icon: Image {
        switch self {
        case .arrow:
            Image(icon: .topArrow)
        case .calendar:
            Image(icon: .calendar)
        case .people:
            Image(icon: .people)
        case .mail:
            Image(icon: .mail)
        case .setting:
            Image(icon: .setting)
        case .wrong:
            Image(icon: .wrong)
        case .logout:
            Image(icon: .out)
        }
    }
}
