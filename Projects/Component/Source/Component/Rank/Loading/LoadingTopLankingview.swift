//
//  TopLankingView.swift
//  Component
//
//  Created by 김은찬 on 7/19/25.
//

import SwiftUI
import Shimmer
import Domain
import Kingfisher

public struct LoadingTopLankingview: View {
    public init() {}
    public var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .redacted(reason: .placeholder)
                .shimmering()
            
            Text("1")
                .font(.title3(.bold))
                .foreground(LegacyColor.Label.alternative)
                .redacted(reason: .placeholder)
                .shimmering()
            
            Text("100")
                .font(.body1(.bold))
                .foreground(LegacyColor.Yellow.normal)
                .redacted(reason: .placeholder)
                .shimmering()
            
            Text("김은찬")
                .font(.body1(.bold))
                .foreground(LegacyColor.Common.white)
                .redacted(reason: .placeholder)
                .shimmering()
        }
        .padding()
        .padding(.vertical, 14)
        .background(LegacyColor.Background.normal)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .foreground(LegacyColor.Label.alternative)
        )
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 12)
    }
}

