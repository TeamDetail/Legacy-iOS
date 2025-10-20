//
//  RankingContentView.swift
//  Feature
//
//  Created by 김은찬 on 10/21/25.
//

import SwiftUI
import Component
import Shared
import Domain

struct RankingContentView: View {
    let rankingList: [RankResponse]?
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                if let data = rankingList {
                    let top3 = Array(data.prefix(3))
                    
                    HStack(spacing: 16) {
                        if top3.count > 1 {
                            TopRankersView(rankType: .two, data: top3[1])
                        }
                        if top3.count > 0 {
                            TopRankersView(rankType: .one, data: top3[0])
                                .padding(.bottom, 40)
                        }
                        if top3.count > 2 {
                            TopRankersView(rankType: .three, data: top3[2])
                        }
                    }
                } else {
                    HStack(spacing: 16) {
                        LoadingTopLankingview()
                        LoadingTopLankingview().padding(.bottom, 40)
                        LoadingTopLankingview()
                    }
                    .padding(.horizontal, 14)
                }
            }
            .padding(.horizontal, 12)
            
            VStack(spacing: 12) {
                if let data = rankingList {
                    let others = Array(data.dropFirst(3))
                    ForEach(Array(others.enumerated()), id: \.1) { (index, data) in
                        let rank = index + 4
                        RankingBoardView(rank: rank, data: data)
                            .padding(.horizontal, 4)
                    }
                } else {
                    ForEach(1...20, id: \.self) { _ in
                        LoadingRankingBoardView()
                    }
                }
            }
            .padding(.vertical, 16)
            .background(LegacyColor.Background.netural)
            .clipShape(size: 16)
            .padding(.horizontal, 12)
        }
    }
}
