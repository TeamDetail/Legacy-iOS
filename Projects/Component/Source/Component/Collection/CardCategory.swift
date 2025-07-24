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
            .font(.label(.bold))
            .foreground(LegacyColor.Common.white)
            .padding(.vertical, 3)
            .padding(.horizontal, 10)
            .background(backgroundColor)
            .clipShape(size: 24)
    }
}
