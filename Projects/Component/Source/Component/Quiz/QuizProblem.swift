//
//  QuizProblem.swift
//  Component
//
//  Created by 김은찬 on 7/17/25.
//

import SwiftUI

public struct QuizProblem: View {
    let isSelected: Bool
    let description: String
    let action: () -> Void
    
    public init(isSelected: Bool = false, description: String, action: @escaping () -> Void) {
        self.isSelected = isSelected
        self.description = description
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            HapticManager.instance.impact(style: .rigid)
            action()
        } label: {
            VStack {
                Text(description)
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Common.white)
            }
            .frame(width: 322, height: 50)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foreground(isSelected ? LegacyColor.Primary.normal : LegacyColor.Line.alternative)
            )
            .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
        }
    }
}
