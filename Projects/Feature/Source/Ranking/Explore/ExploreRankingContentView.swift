//
//  ExploreRankingContentView.swift
//  Feature
//
//  Created by 김은찬 on 10/21/25.
//

import SwiftUI
import Component
import Shared
import Domain
import FlowKit

struct ExploreRankingContentView: View {
    @Flow var flow
    let rankingList: [ExploreRankingResponse]?
    var rankType: RankType
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if rankType == .friend, (rankingList?.isEmpty ?? true) {
                    EmptyFriendView(flow: _flow)
                } else {
                    if let data = rankingList {
                        let top3 = Array(data.prefix(3))
                        TopThreeExploreView(top3: top3)
                            .padding(.top, 20)
                        
                        VStack(spacing: 12) {
                            let others = Array(data.dropFirst(3))
                            ForEach(Array(others.enumerated()), id: \.1.nickname) { (index, item) in
                                ExRankingBoardView(rank: index + 4, data: item)
                                    .padding(.horizontal, 4)
                            }
                        }
                        .padding(.vertical, 16)
                        .background(LegacyColor.Background.netural)
                        .clipShape(size: 16)
                        .padding(.horizontal, 12)
                        .padding(.top, 16)
                    } else {
                        LegacyLoadingView()
                    }
                }
            }
        }
    }
}
