//
//  TopRankEnum.swift
//  Component
//
//  Created by 김은찬 on 7/19/25.
//

import Foundation

public enum TopRankEnum {
    case one
    case two
    case three
    
    var strokeColor: LegacyColorable {
        switch self {
        case .one:
            return LegacyColor.Purple.netural
        case .two:
            return LegacyColor.Red.netural
        case .three:
            return LegacyColor.Blue.netural
        }
    }
    
    var ranking: String {
        switch self {
        case .one:
            return "1위"
        case .two:
            return "2위"
        case .three:
            return "3위"
        }
    }
}
