//
//  CardCategory.swift
//  Component
//
//  Created by 김은찬 on 7/24/25.
//

import SwiftUI

struct CardCategory: View {
    let category: String
    let backgroundColor: LegacyColorable
    
    public init(category: String, backgroundColor: LegacyColorable) {
        self.category = category
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Text(category)
            .font(.caption2(.bold))
            .foreground(LegacyColor.Common.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(height: 18)
            .background(backgroundColor)
            .clipShape(size: 24)
    }
}
