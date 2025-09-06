//
//  TestMiddleColor.swift
//  Shared
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI
import Component

public func makeStyledText(count: Int) -> AttributedString {
    var attributed = AttributedString("오늘 총 \(count)개 구매")
    
    if let range = attributed.range(of: "\(count)") {
        attributed[range].foregroundColor = LegacyColor.Yellow.netural.color.rawValue
    }
    return attributed
}

public func makeSectionTitle(_ type: CourseSectionType) -> AttributedString {
    var attributed = AttributedString(type.rawValue)
    
    if let highlight = type.highlight,
       let range = attributed.range(of: highlight) {
        attributed[range].foregroundColor = type.highlightColor.color.rawValue
    }
    
    return attributed
}

public func makeConfirmModalText(_ price: Int) -> AttributedString {
    var attributed = AttributedString("\(price) 크레딧을 소모합니다.")
    
    if let range = attributed.range(of: "\(price) 크레딧을") {
        attributed[range].foregroundColor = LegacyColor.Yellow.netural.color.rawValue
    }
    return attributed
}
