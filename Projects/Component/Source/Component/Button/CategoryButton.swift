//
//  CategoryButton.swift
//  Feature
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI

public struct CategoryButton: View {
    let category: String
    let select: Bool
    let action: () -> Void
    
    public init(category: String, select: Bool, action: @escaping () -> Void) {
        self.category = category
        self.select = select
        self.action = action
    }
    
    public var body: some View {
        Button {
            withAnimation(.spring(duration: 0.2)) {
                HapticManager.instance.impact(style: .light)
                action()
            }
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

