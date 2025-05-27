//
//  CategoryButtonGroup.swift
//  Component
//
//  Created by 김은찬 on 5/27/25.
//

import SwiftUI

public struct CategoryButtonGroup: View {
    let categories: [String]
    @Binding var selection: Int
    
    public init(categories: [String], selection: Binding<Int>) {
        self.categories = categories
        self._selection = selection
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            ForEach(Array(categories.enumerated()), id: \.offset) { idx, category in
                CategoryButton(
                    category: category,
                    select: selection == idx
                ) {
                    selection = idx
                }
            }
        }
    }
}
