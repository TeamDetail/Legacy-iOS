//
//  CourseEnumType.swift
//  Component
//
//  Created by 김은찬 on 8/1/25.
//

import Foundation

public enum ProgressStatus: String, CaseIterable {
    case incomplete = "미완료"
    case complete = "완료"
    case all = "전체"
}

public enum SortType: String, CaseIterable {
    case latest = "최신"
    case popular = "인기"
    case clearCount = "클리어수"
}

public enum ContentType: String, CaseIterable {
    case all = "전체"
    case general = "일반"
    case event = "이벤트"
}

public enum ButtonType {
    case big
    case small
    
    var widthSize: CGFloat {
        switch self {
        case .big:
            return 81
        case .small:
            return 69
        }
    }
}
