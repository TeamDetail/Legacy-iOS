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
    
    var body: some View {
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
