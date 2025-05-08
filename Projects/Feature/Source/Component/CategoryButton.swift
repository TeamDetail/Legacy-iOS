//
//  CategoryButton.swift
//  Feature
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI
import Legacy_DesignSystem

struct CategoryButton: View {
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
                .background(select ? LegacyColor.Primary.normal : LegacyColor.Line.netural)
                .clipShape(size: 50)
        }
    }
}

