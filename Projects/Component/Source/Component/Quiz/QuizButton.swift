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
    let action: () -> Void
    
    public init(title: String, buttonType: QuizEnum, action: @escaping () -> Void) {
        self.title = title
        self.buttonType = buttonType
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.caption1(.bold))
                .foreground(buttonType.color)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .frame(minWidth: 60, maxWidth: buttonType.width, minHeight: 40, maxHeight: 40)
                .background(LegacyColor.Fill.normal)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 5)
                        .stroke(lineWidth: 2)
                        .foreground(buttonType.stroke)
                )
                .clipShape(size: 12)
        }
    }
}
