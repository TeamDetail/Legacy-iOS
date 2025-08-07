//
//  EventTag.swift
//  Component
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI

public enum EventButtonType {
    case small
    case big
    
    var width: CGFloat {
        switch self {
        case .small:
            return 57
        case .big:
            return 74
        }
    }
    
    var height: CGFloat {
        switch self {
        case .small:
            return 16
        case .big:
            return 22
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .small:
            return 10
        case .big:
            return 14
        }
    }
    
}

public struct EventTag: View {
    let buttonType: EventButtonType
    
    public init(_ buttonType: EventButtonType) {
        self.buttonType = buttonType
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("이벤트 중!")
                .font(.custom("Pretendard-Bold", size: buttonType.fontSize))
                .foreground(LegacyColor.Common.white)
        }
        .frame(width: buttonType.width, height: buttonType.height)
        .background(LegacyColor.Red.netural)
        .cornerRadius(999)
    }
}
