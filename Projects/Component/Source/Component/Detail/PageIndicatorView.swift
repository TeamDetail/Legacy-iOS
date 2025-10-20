//
//  PageIndicatorView.swift
//  Component
//
//  Created by 김은찬 on 10/20/25.
//

import SwiftUI

public struct PageIndicatorView: View {
    let currentIndex: Int
    let totalCount: Int
    
    public init(currentIndex: Int, totalCount: Int) {
        self.currentIndex = currentIndex
        self.totalCount = totalCount
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            if currentIndex == 0 {
                Text("옆으로 넘겨서 더 많은 유적지 확인 →")
                    .font(.caption1(.medium))
                    .foreground(LegacyColor.Label.netural)
            } else {
                Text("\(currentIndex + 1) / \(totalCount)")
                    .font(.caption1(.medium))
                    .foreground(LegacyColor.Label.netural)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 24)
        .background(LegacyColor.Fill.netural)
        .clipShape(size: 12)
        .padding(.horizontal, 8)
    }
}
