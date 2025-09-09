//
//  InventoryItem.swift
//  Component
//
//  Created by 김은찬 on 9/9/25.
//

import SwiftUI

public struct InventoryItem: View {
    let action: () -> Void
    let test: String
    
    public init(action: @escaping () -> Void, test: String) {
        self.test = test
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            VStack {
                Text(test)
                Image(systemName: "backpack.fill")
                    .foreground(LegacyColor.Common.white)
            }
            .frame(width: 48, height: 48)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 5)
                    .stroke(lineWidth: 1)
                    .foreground(LegacyColor.Line.alternative)
            )
        }
    }
}
