import SwiftUI

public enum LegacyTabItem: Int, CaseIterable {
    case shop, medal, flag, course, trophy
    
    var icon: Image {
        switch self {
        case .flag:
            Image(icon: .flag)
        case .course:
            Image(icon: .course)
        case .shop:
            Image(icon: .shop)
        case .trophy:
            Image(icon: .trophy)
        case .medal:
            Image(icon: .medal)
        }
    }
    
    var label: String {
        switch self {
        case .flag:
            "탐험"
        case .course:
            "코스"
        case .shop:
            "상점"
        case .trophy:
            "랭킹"
        case .medal:
            "도전과제"
        }
    }
}
