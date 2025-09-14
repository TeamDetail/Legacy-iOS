//
//  LegacyStatusEnum.swift
//  Component
//
//  Created by 김은찬 on 9/14/25.
//

import SwiftUI

public enum LegacyStatusType: String {
    case success
    case failure
    
    var icon: Image {
        switch self {
        case .success:
            Image(icon: .checkStatus)
        case .failure:
            Image(icon: .closeStatus)
        }
    }
}
