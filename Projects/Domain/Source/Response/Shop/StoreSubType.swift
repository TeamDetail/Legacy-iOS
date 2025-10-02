//
//  StoreSubType.swift
//  Domain
//
//  Created by 김은찬 on 10/2/25.
//

import Foundation

public enum StoreSubType: String, EnumProtocol, CaseIterable, Hashable {
    case region = "REGION"
    case nation = "NATION"
    case line = "LINE"
    
    public var typeName: String {
        switch self {
        case .region:
            return "지역"
        case .nation:
            return "시대"
        case .line:
            return "계열"
        }
    }
    
    public var sortOrder: Int {
        switch self {
        case .nation: return 0
        case .line: return 1
        case .region: return 2
        }
    }
}
