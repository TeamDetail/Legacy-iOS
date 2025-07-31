//
//  CourseButton.swift
//  Component
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI

public struct CourseButton: View {
    let title: String
    let action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            Text(title)
                .font(.caption1(.bold))
                .foreground(LegacyColor.Common.white)
                .frame(maxWidth: .infinity)
                .frame(height: 36)
                .background(LegacyColor.Fill.normal)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 5)
                        .stroke(lineWidth: 1)
                        .foreground(LegacyColor.Line.netural)
                )
                .clipShape(size: 8)
        }
    }
}
