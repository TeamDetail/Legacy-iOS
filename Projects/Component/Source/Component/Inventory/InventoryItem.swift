//
//  InventoryItem.swift
//  Component
//
//  Created by 김은찬 on 9/9/25.
//

import SwiftUI
import Domain

public struct InventoryItem: View {
    let item: InventoryResponse?
    let action: () -> Void
    
    public init(item: InventoryResponse?, action: @escaping () -> Void) {
        self.item = item
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            VStack {
                if let item = item {
                    Image(icon: item.itemType == .cardPack ? .cardPack : .moneyBundle)
                        .resizable()
                        .frame(width: 48, height: 48)
                } else {
                    Image(icon: .cardPack)
                        .resizable()
                        .frame(width: 48, height: 48)
                }
            }
            .frame(width: 48, height: 48)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foreground(LegacyColor.Line.alternative)
            )
        }
    }
    
}
