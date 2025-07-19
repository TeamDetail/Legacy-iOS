//
//  LoadingRankingBoardView.swift
//  Component
//
//  Created by 김은찬 on 7/19/25.
//

import SwiftUI
import Shimmer
import Domain

public struct LoadingRankingBoardView: View {
    public init() {}
    public var body: some View {
        HStack {
            Text("1")
                .font(.bitFont(size: 28))
                .foreground(LegacyColor.Common.white)
                .redacted(reason: .placeholder)
                .shimmering()
                .padding(.trailing, 10)
            
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 48, height: 48)
                .redacted(reason: .placeholder)
                .shimmering()
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("김은찬")
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Common.white)
                        .redacted(reason: .placeholder)
                        .shimmering()
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
            }
            
            Text("100")
                .font(.bitFont(size: 18))
                .foreground(LegacyColor.Primary.normal)
                .redacted(reason: .placeholder)
                .shimmering()
        }
        .padding(.horizontal, 20)
    }
}

