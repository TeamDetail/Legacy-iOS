//
//  BackButton.swift
//  Component
//
//  Created by 김은찬 on 5/25/25.
//

import SwiftUI

public struct BackButton: ViewModifier {
    let title: String
    let action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        Button {
            withAnimation(.spring(duration: 0.2)) {
                HapticManager.instance.impact(style: .soft)
                action()
            }
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                Text(title)
            }
            .font(.heading1(.bold))
            .foreground(LegacyColor.Common.white)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding()
            Spacer()
        }
        content
    }
}
