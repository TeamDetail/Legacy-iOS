//
//  ProblemProgress.swift
//  Component
//
//  Created by 김은찬 on 7/19/25.
//

import SwiftUI

public struct ProgressIndicator: View {
    let totalCount: Int
    let currentIndex: Int
    
    public init(totalCount: Int, currentIndex: Int) {
        self.totalCount = totalCount
        self.currentIndex = currentIndex
    }
    
    public var body: some View {
        HStack {
            Spacer()
            HStack(spacing: 6) {
                ForEach(0..<min(totalCount, 3), id: \.self) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foreground(index == currentIndex ? LegacyColor.Primary.normal : LegacyColor.Label.normal)
                }
            }
            .padding(.horizontal, 8)
        }
    }
}
