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
                    DetailRatingInfoItem()
                    Spacer()
                }
                
                AnimationButton {
                    onComment()
                } label: {
                    Text("한줄평 남기기")
                        .font(.caption1(.bold))
                        .foreground(LegacyColor.Label.netural)
                        .padding(.horizontal, 6)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .background(LegacyColor.Fill.normal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 2)
                                .foreground(LegacyColor.Line.netural)
                        )
                        .clipShape(size: 12)
                }
            }
            
            if let url = URL(string: data.ruinsImage) {
                ZStack(alignment: .bottomLeading) {
                    KFImage(url)
                        .placeholder { _ in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 160, height: 224)
                                .redacted(reason: .placeholder)
                                .shimmering()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 224)
                        .clipShape(size: 16)
                    
                    
                    Text(data.name)
                        .font(.bitFont(size: 14))
                        .foreground(LegacyColor.Common.white)
                        .padding(6)
                        .clipShape(size: 8)
                        .padding([.leading, .bottom], 8)
                }
                .overlay(
                    RuinsCategory(
                        category: data.category
                    )
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding([.leading, .top], 8),
                    alignment: .topLeading
                )
            }
        }
        .padding(6)
    }
}
