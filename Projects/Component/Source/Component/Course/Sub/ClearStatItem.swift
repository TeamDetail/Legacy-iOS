//
//  NonInteractiveStatItem.swift
//  Component
//
//  Created by 김은찬 on 8/7/25.
//

import SwiftUI

struct ClearStatItem: View {
    let statType: StatEnum
    let text: String
    let isChecked: Bool
    let size: StatSize
    
    var body: some View {
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
