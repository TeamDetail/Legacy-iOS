//
//  AllRewardButton.swift
//  Component
//
//  Created by 김은찬 on 8/19/25.
//

import SwiftUI

public struct AllRewardButton: View {
    let action: () -> Void
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            Text("보상 일괄 수령")
                .font(.caption1(.bold))
                .foreground(LegacyColor.Yellow.netural)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(LegacyColor.Fill.normal)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 5)
                        .stroke(lineWidth: 1)
                        .foreground(LegacyColor.Yellow.netural)
                )
                .clipShape(size: 8)
        }
    }
}

#Preview {
    AllRewardButton() {}
}
