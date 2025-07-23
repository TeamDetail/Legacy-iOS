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
            withAnimation(.spring(duration: animationDuration)) {
                action()
            }
        } label: {
            label()
        }
    }
}
