//
//  RankingTypeButtonGroup.swift
//  Component
//
//  Created by 김은찬 on 10/21/25.
//

import SwiftUI
import Domain

public struct RankingTypeButtonGroup: View {
    @Binding var rankType: RankType
    
    public init(rankType: Binding<RankType>) {
        self._rankType = rankType
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            LankingCategoryButton(
                category: "전체",
                select: rankType == .all
            ) {
                rankType = .all
            }
            
            LankingCategoryButton(
                category: "친구",
                select: rankType == .friend
            ) {
                rankType = .friend
            }
        }
    }
}
