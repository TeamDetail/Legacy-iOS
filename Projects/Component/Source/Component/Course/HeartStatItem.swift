//
//  StatItem.swift
//  Component
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI

enum StatEnum {
    case heart
    case flag
    
    var selectColor: LegacyColorable {
        switch self {
        case .heart:
            return LegacyColor.Red.netural
        case .flag:
            return LegacyColor.Green.normal
        }
    }
    
    var icon: LegacyIconography {
        switch self {
        case .heart:
            return .heart
        case .flag:
            return .flag
        }
    }
}

enum StatSize {
    case small
    case big
    
    var iconSize: CGFloat {
        switch self {
        case .small:
            return 14
        case .big:
            return 20
        }
    }
}


struct HeartStatItem: View {
    @Binding var isChecked: Bool
    let statType: StatEnum
    let text: String
    let size: StatSize
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Image(icon: statType.icon)
                    .resizable()
                    .frame(width: size.iconSize, height: size.iconSize)
                Text(text)
                    .font(size == .small ? .caption2(.medium) : .body2(.medium))
            }
            .foreground(isChecked ? statType.selectColor : LegacyColor.Label.alternative)
        }
    }
}
