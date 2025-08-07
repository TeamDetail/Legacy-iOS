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


struct HeartStatItem: View {
    @Binding var isChecked: Bool
    let statType: StatEnum
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Image(icon: statType.icon)
                    .resizable()
                    .frame(width: 14, height: 14)
                Text(text)
                    .font(.caption2(.medium))
            }
            .foreground(isChecked ? statType.selectColor : LegacyColor.Label.alternative)
        }
    }
}

