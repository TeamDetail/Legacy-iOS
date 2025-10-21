//
//  EmptyFriendView.swift
//  Feature
//
//  Created by 김은찬 on 10/21/25.
//

import Domain
import SwiftUI
import FlowKit
import Component

struct EmptyFriendView: View {
    @Flow var flow
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("친구가 없어요!")
                .font(.heading1(.bold))
                .foreground(LegacyColor.Common.white)
            
            AnimationButton {
                flow.push(FriendsView())
            } label: {
                Text("추가하러 가기")
                    .frame(width: 150, height: 40)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Purple.normal)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Purple.normal)
                    )
            }
            Spacer()
        }
    }
}

struct TopThreeExploreView: View {
    let top3: [ExploreRankingResponse]
    
    var body: some View {
        HStack(spacing: 16) {
            if top3.count > 1 {
                ExTopRankersView(rankType: .two, data: top3[1])
            }
            if top3.count > 0 {
                ExTopRankersView(rankType: .one, data: top3[0])
                    .padding(.bottom, 40)
            }
            if top3.count > 2 {
                ExTopRankersView(rankType: .three, data: top3[2])
            }
        }
        .padding(.horizontal, 12)
    }
}

struct TopThreeLevelView: View {
    let top3: [LevelRankingResponse]
    
    var body: some View {
        HStack(spacing: 16) {
            if top3.count > 1 {
                LvTopRankersView(rankType: .two, data: top3[1])
            }
            if top3.count > 0 {
                LvTopRankersView(rankType: .one, data: top3[0])
                    .padding(.bottom, 40)
            }
            if top3.count > 2 {
                LvTopRankersView(rankType: .three, data: top3[2])
            }
        }
        .padding(.horizontal, 12)
    }
}
