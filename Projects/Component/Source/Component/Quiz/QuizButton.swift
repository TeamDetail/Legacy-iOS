//
//  QuizButton.swift
//  Component
//
//  Created by 김은찬 on 7/17/25.
//

import SwiftUI

public struct QuizButton: View {
    let title: String
    let buttonType: QuizEnum
    let isDisabled: Bool
    let action: () -> Void
    
    public init(title: String, buttonType: QuizEnum, isDisabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.buttonType = buttonType
        self.isDisabled = isDisabled
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption1(.bold))
                .foreground(isDisabled ? LegacyColor.Line.normal : buttonType.color)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 6)
                .padding(.vertical, 12)
                .frame(width: buttonType.width)
                .background(LegacyColor.Fill.normal)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 5)
                        .stroke(lineWidth: 2)
                        .foreground(isDisabled ? LegacyColor.Line.normal : buttonType.stroke)
                )
                .clipShape(size: 12)
        }
        .disabled(isDisabled)
    }
}
