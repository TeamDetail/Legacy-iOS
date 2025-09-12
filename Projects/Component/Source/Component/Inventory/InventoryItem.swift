//
//  InventoryItem.swift
//  Component
//
//  Created by 김은찬 on 9/9/25.
//

import SwiftUI

public struct InventoryItem: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            VStack {
                Image(icon: .cap)
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
