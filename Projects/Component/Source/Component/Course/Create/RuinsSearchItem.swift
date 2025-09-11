//
//  RuinsSearchItem.swift
//  Component
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI
import Domain

public struct RuinsSearchItem: View {
    let data: RuinsDetailResponse
    public init(data: RuinsDetailResponse) {
        self.data = data
    }
    public var body: some View {
        AnimationButton {
            
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 14) {
                    Text("#\(data.ruinsId)")
                        .font(.caption1(.medium))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text(data.name)
                        .font(.heading1(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    DetailRatingInfoItem()
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                if let card = data.card {
                    RuinCardView(data: card)
                        .frame(width: 120, height: 168)
                } else {
                    ErrorRuinsCardView()
                        .frame(width: 120, height: 168)
                }
            }
        }
    }
}
