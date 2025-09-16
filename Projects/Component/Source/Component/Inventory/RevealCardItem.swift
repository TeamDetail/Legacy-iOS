//
//  RevealCardItem.swift
//  Component
//
//  Created by 김은찬 on 9/15/25.
//

import SwiftUI
import Domain

struct RevealCardItem: View {
    let cardData: Card
    @Binding var revealedCount: Int
    var onRevealCompleted: (() -> Void)?
    
    @State private var isFlipping: Bool = false
    @State private var showingBack: Bool = false
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            AnimationButton {
                revealCard()
            } label: {
                Image(icon: .emptyCard)
                    .rotation3DEffect(
                        .degrees(rotation),
                        axis: (x: 0, y: 1, z: 0),
                        perspective: 0.6
                    )
            }
            .disabled(isFlipping || showingBack)
            .opacity(showingBack ? 0 : 1)
            
            RuinCardView(data: cardData)
                .aspectRatio(4/7, contentMode: .fit)
                .rotation3DEffect(
                    .degrees(rotation - 180),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.6
                )
                .opacity(showingBack ? 1 : 0)
        }
        .aspectRatio(4/7, contentMode: .fit)
    }
    
    private func revealCard() {
        guard !isFlipping && !showingBack else { return }
        isFlipping = true
        
        withAnimation(.linear(duration: 0.36)) {
            rotation += 180
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            showingBack = true
            revealedCount += 1
            onRevealCompleted?()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.36) {
            isFlipping = false
        }
    }
}

