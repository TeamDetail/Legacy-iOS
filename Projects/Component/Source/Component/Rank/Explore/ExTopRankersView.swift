//
//  ExTopRankersView.swift
//  Component
//
//  Created by 김은찬 on 6/4/25.
//

import SwiftUI
import Shimmer
import Domain
import Kingfisher

public struct ExTopRankersView: View {
    let rankType: TopRankEnum
    let data: ExploreRankingResponse
    
    public init(rankType: TopRankEnum, data: ExploreRankingResponse) {
        self.rankType = rankType
        self.data = data
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                if let url = URL(string: data.imageUrl) {
                    KFImage(url)
                        .placeholder { _ in
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 80, height: 80)
                                .redacted(reason: .placeholder)
                                .shimmering()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .clipped()
                        .overlay(
                            Circle()
                                .stroke(lineWidth: 3)
                                .foreground(rankType.strokeColor)
                        )
                        .offset(y: -15)
                }
            }
            .frame(height: 80)
            
            VStack(spacing: 4) {
                Text(rankType.ranking)
                    .font(.title3(.bold))
                    .foreground(rankType.strokeColor)
                
                Text("\(data.allBlocks)블록")
                    .font(.body2(.bold))
                    .foreground(LegacyColor.Yellow.normal)
                
                Text(data.nickname)
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Common.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 8)
            .padding(.top, 4)
            
            if !data.title.name.isEmpty {
                TitleBadge(
                    title: data.title.name,
                    styleId: data.title.styleId
                )
                .padding(.horizontal, 8)
                .padding(.top, 8)
                .padding(.bottom, 12)
            } else {
                Spacer()
                    .frame(height: 12)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 260)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .foreground(rankType.strokeColor)
        )
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
    }
}
