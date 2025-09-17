//
//  ShopItem.swift
//  Component
//
//  Created by 김은찬 on 8/27/25.
//

import SwiftUI
import Domain

public struct ShopItem: View {
    let data: CardPack
    let action: () -> Void
    
    public init(data: CardPack, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    public var body: some View {
        HStack {
            Image(icon: .cardPack)
                .resizable()
                .frame(width: 84, height: 84)
                .clipShape(size: 12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(data.cardpackName)
                    .font(.bitFont(size: 20))
                    .foreground(LegacyColor.Common.white)
                
                Text(data.cardpackContent)
                    .font(.caption2(.medium))
                    .foreground(LegacyColor.Label.alternative)
                
                AnimationButton {
                    action()
                } label: {
                    Text("\(data.price) 크레딧")
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
            .frame(maxWidth: .infinity, alignment: .leading) // VStack 폭 채우기
        }
        .frame(maxWidth: .infinity) // HStack 폭 채우기
        .padding(.horizontal, 14)
    }
}
