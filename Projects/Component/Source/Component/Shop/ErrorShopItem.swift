//
//  ErrorShopItem.swift
//  Component
//
//  Created by 김은찬 on 8/27/25.
//

import SwiftUI
import Shimmer

public struct ErrorShopItem: View {
    public init() {}
    
    public var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 84, height: 84)
                .redacted(reason: .placeholder)
                .shimmering()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("아이템 이름")
                    .font(.bitFont(size: 20))
                    .foreground(LegacyColor.Common.white)
                    .redacted(reason: .placeholder)
                    .shimmering()
                
                Text("아이템 설명 텍스트입니다.")
                    .redacted(reason: .placeholder)
                    .shimmering()
                
                AnimationButton {
                    
                } label: {
                    Text("로딩 중입니다..")
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .font(.caption2(.bold))
                        .foreground(LegacyColor.Label.netural)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Line.alternative)
                        )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14)
    }
}

#Preview {
    ErrorShopItem()
}
