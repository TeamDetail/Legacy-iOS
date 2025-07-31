//
//  CourseSectionType.swift
//  Shared
//
//  Created by 김은찬 on 7/31/25.
//

import Foundation
import Component

public enum CourseSectionType: String, CaseIterable {
    case popular = "현재 최고 인기 코스"
    case event = "이벤트 진행중인 코스"
    case recent = "최근 제작된 코스"
    
    var highlight: String? {
        switch self {
        case .popular: return "인기"
        case .event: return "이벤트"
        case .recent: return "최근 제작"
        }
    }
    
    var highlightColor: LegacyColorable {
        switch self {
        case .popular: return LegacyColor.Red.netural
        case .event: return LegacyColor.Yellow.netural
        case .recent: return LegacyColor.Green.normal
        }
    }
}
