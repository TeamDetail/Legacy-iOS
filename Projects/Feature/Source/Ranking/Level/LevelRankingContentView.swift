//
//  LevelRankingContentView.swift
//  Feature
//
//  Created by 김은찬 on 10/21/25.
//

import SwiftUI
import Component
import Shared
import Domain
import FlowKit

struct LevelRankingContentView: View {
    @Flow var flow
    let rankingList: [LevelRankingResponse]?
    var rankType: RankType
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let data = rankingList {
                    if rankType == .friend, (data.isEmpty) {
                        EmptyFriendView(flow: _flow)
                    } else {
                        let top3 = Array(data.prefix(3))
                        TopThreeLevelView(top3: top3)
                        
                        VStack(spacing: 12) {
                            let others = Array(data.dropFirst(3))
                            ForEach(Array(others.enumerated()), id: \.1.nickname) { (index, item) in
                                LvRankingBoardView(rank: index + 4, data: item)
                                    .padding(.horizontal, 4)
                            }
                        }
                        .padding(.vertical, 16)
                        .background(LegacyColor.Background.netural)
                        .clipShape(size: 16)
                        .padding(.horizontal, 12)
                        .padding(.top, 16)
                    }
                } else {
                    LegacyLoadingView()
                }
            }
        }
    }
}
