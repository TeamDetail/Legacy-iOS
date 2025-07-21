//
//  QuizEnum.swift
//  Component
//
//  Created by 김은찬 on 7/19/25.
//

import SwiftUI
import Foundation

public enum QuizEnum {
    case small
    case medium
    case cancel
    
    var color: LegacyColorable {
        switch self {
        case .small:
            return LegacyColor.Common.white
        case .medium:
            return LegacyColor.Blue.netural
        case .cancel:
            return LegacyColor.Common.white
        }
    }
    
    
    var stroke: LegacyColorable {
        switch self {
        case .small:
            return LegacyColor.Label.alternative
        case .medium:
            return LegacyColor.Blue.netural
        case .cancel:
            return LegacyColor.Label.alternative
        }
    }
    
    var width: CGFloat {
        switch self {
        case .small:
            return 64
        case .medium:
            return 185
        case .cancel:
            return 100
        }
    }
}
