//
//  RuinsDetailContent.swift
//  Component
//
//  Created by 김은찬 on 8/18/25.
//

import SwiftUI
import Domain
import Kingfisher
import Shimmer

struct RuinsDetailContent: View {
    public let data: RuinsDetailResponse
    public let onComment: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("유적지 탐험")
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Text("#\(data.ruinsId)")
                        .font(.caption1(.medium))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text(data.name)
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Label.normal)
                }
                
                HStack {
                    DetailRatingInfoItem(data)
                    Spacer()
                }
                
                AnimationButton {
                    onComment()
                } label: {
                    Text("한줄평 남기기")
                        .font(.caption1(.bold))
                        .foreground(LegacyColor.Label.netural)
                        .padding(.horizontal, 4)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .background(LegacyColor.Fill.normal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Line.netural)
                        )
                        .clipShape(size: 12)
                }
            }
            
            if let card = data.card {
                RuinCardView(data: card)
                    .frame(width: 160, height: 234)
            } else {
                ErrorRuinsCardView()
                    .frame(width: 160, height: 234)
            }
        }
        .padding(6)
    }
}
