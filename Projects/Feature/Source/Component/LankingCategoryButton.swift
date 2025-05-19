//
//  LankingCategoryButton.swift
//  Feature
//
//  Created by dgsw27 on 5/14/25.
//

import SwiftUI
import Component

struct LankingCategoryButton: View {
    let category: String
    let select: Bool
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(category)
                .font(.caption1(.bold))
                .foreground(select ? LegacyColor.Common.white : LegacyColor.Label.assistive)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(select ? LegacyColor.Red.netural : LegacyColor.Line.netural)
                .clipShape(size: 50)
        }
    }
}
