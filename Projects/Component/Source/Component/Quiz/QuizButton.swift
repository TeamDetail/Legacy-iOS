//
//  QuizButton.swift
//  Component
//
//  Created by 김은찬 on 7/17/25.
//

import SwiftUI

public struct QuizButton: View {
    let title: String
    let color: LegacyColorable
    let strokeColor: LegacyColorable
    let width: CGFloat
    let action: () -> Void
    
    public init(title: String, color: LegacyColorable, strokeColor: LegacyColorable, width: CGFloat, action: @escaping () -> Void) {
        self.title = title
        self.color = color
        self.strokeColor = strokeColor
        self.width = width
        self.action = action
    }
    
    public var body: some View {
        Button {
            withAnimation(.spring(duration: 0.2)) {
                HapticManager.instance.impact(style: .soft)
                action()
            }
        } label: {
            Text(title)
                .font(.caption1(.bold))
                .foreground(color)
                .frame(width: width, height: 40)
                .background(LegacyColor.Fill.normal)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 2)
                        .foreground(strokeColor)
                )
                .clipShape(size: 12)
        }
    }
}
