//
//  AnimationButton.swift
//  Component
//
//  Created by 김은찬 on 7/23/25.
//

import SwiftUI

public struct AnimationButton<Label: View>: View {
    let animationDuration: Double
    let action: () -> Void
    let label: () -> Label
    
    @State private var isPressed = false
    
    public init(
        animationDuration: Double = 0.2,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.animationDuration = animationDuration
        self.action = action
        self.label = label
    }
    
    public var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation(.spring(duration: animationDuration)) {
                    action()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
        } label: {
            label()
                .scaleEffect(isPressed ? 0.92 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(.plain)
    }
}
