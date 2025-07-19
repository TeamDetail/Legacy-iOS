//
//  RankingBoardView.swift
//  Component
//
//  Created by 김은찬 on 6/4/25.
//

import SwiftUI
import Shimmer
import Domain
import Kingfisher

public struct TopRankersView: View {
    let rankType: TopRankEnum
    let data: RankResponse
    
    public init(rankType: TopRankEnum, data: RankResponse) {
        self.rankType = rankType
        self.data = data
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            if let url = URL(string: data.imageUrl) {
                KFImage(url)
                    .placeholder { _ in
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(size: 300)
            }
            
            Text(rankType.ranking)
                .font(.title3(.bold))
                .foreground(rankType.strokeColor)
            
            Text("\(data.allBlocks)블록")
                .font(.body1(.bold))
                .foreground(LegacyColor.Yellow.normal)
            
            Text(data.nickname)
                .font(.body1(.bold))
                .foreground(LegacyColor.Common.white)
            
            if !data.title.name.isEmpty {
                TitleBadge(data.title.name, color: LegacyColor.Yellow.alternative)
            }
        }
        .padding()
        .background(LegacyColor.Background.normal)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .foreground(rankType.strokeColor)
        )
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 12)
    }
}
