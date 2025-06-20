//
//  RuinsCategory.swift
//  Component
//
//  Created by 김은찬 on 6/21/25.
//

import SwiftUI

public struct RuinsCategory: View {
    let category: String
    public init(category: String) {
        self.category = category
    }
    public var body: some View {
        Text(category)
            .font(.label(.bold))
            .foreground(LegacyColor.Common.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .background(Color.purple)
            .cornerRadius(24)
    }
}
