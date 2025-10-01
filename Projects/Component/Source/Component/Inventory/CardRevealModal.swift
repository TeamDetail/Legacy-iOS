//
//  CardRevealModal.swift
//  Component
//

import SwiftUI
import Domain

public struct CardRevealModal: View {
    let packName: String
    let cards: [Card]
    let close: () -> Void
    @State private var revealedCount: Int = 0
    @State private var currentIndex: Int = 0
    @State private var isInitialAnimationComplete: Bool = false
    @State private var revealedIndices: Set<Int> = []
    
    public init(packName: String, cards: [Card], close: @escaping () -> Void) {
        self.packName = packName
        self.cards = cards
        self.close = close
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            headerView
            cardStackView
            pageIndicator
            closeButton
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foreground(LegacyColor.Background.normal)
        )
        .padding(.horizontal, 20)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isInitialAnimationComplete = true
            }
        }
    }
    
    // MARK: - Header
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("카드 획득!")
                .font(.title2(.bold))
                .foreground(LegacyColor.Common.white)
            
            HStack(spacing: 4) {
                Text("~ \(packName) ~")
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Label.alternative)
                
                if currentIndex < cards.count - 1 {
                    skipButton
                }
            }
        }
        .padding(.top, 32)
        .padding(.bottom, 24)
        .opacity(isInitialAnimationComplete ? 1 : 0)
        .offset(y: isInitialAnimationComplete ? 0 : -20)
        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2), value: isInitialAnimationComplete)
    }
    
    private var skipButton: some View {
        Button(action: handleSkip) {
            HStack(spacing: 4) {
                Text("건너뛰기")
                    .font(.caption2(.medium))
                Image(systemName: "chevron.right.2")
                    .font(.system(size: 10, weight: .semibold))
            }
            .foreground(LegacyColor.Label.assistive)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Capsule()
                    .foreground(LegacyColor.Fill.alternative)
                    .opacity(0.6)
            )
        }
    }
    
    // MARK: - Card Stack
    private var cardStackView: some View {
        ZStack {
            ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
                CardItemView(
                    card: card,
                    index: index,
                    currentIndex: currentIndex,
                    revealedCount: $revealedCount,
                    revealedIndices: $revealedIndices,
                    onRevealCompleted: {
                        handleCardReveal(at: index)
                    },
                    onTap: {
                        handleCardTap(at: index)
                    }
                )
            }
        }
        .frame(height: 300)
        .padding(.horizontal, 40)
        .clipped()
        .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onEnded { value in
                let threshold: CGFloat = 50
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    if value.translation.width > threshold && currentIndex > 0 {
                        currentIndex -= 1
                    } else if value.translation.width < -threshold && currentIndex < cards.count - 1 {
                        currentIndex += 1
                    }
                }
            }
    }
    
    // MARK: - Page Indicator
    private var pageIndicator: some View {
        Text("\(currentIndex + 1) / \(cards.count)")
            .font(.caption1(.medium))
            .foreground(LegacyColor.Label.netural)
            .padding(.top, 24)
            .padding(.bottom, 12)
            .opacity(isInitialAnimationComplete ? 1 : 0)
            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.3), value: isInitialAnimationComplete)
    }
    
    // MARK: - Close Button
    private var closeButton: some View {
        AnimationButton {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                close()
            }
        } label: {
            Text("획득 완료하고 닫기")
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .font(.caption1(.bold))
                .foreground(LegacyColor.Common.white)
                .background(LegacyColor.Fill.normal)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 5)
                        .stroke(lineWidth: 1)
                        .foreground(LegacyColor.Line.alternative)
                )
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 14)
        .opacity(currentIndex + 1 == cards.count ? 1 : 0)
        .offset(y: currentIndex + 1 == cards.count ? 0 : 20)
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: currentIndex)
    }
    
    // MARK: - Actions
    private func handleSkip() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            for i in 0..<cards.count {
                revealedIndices.insert(i)
            }
            revealedCount = cards.count
            currentIndex = cards.count - 1
        }
    }
    
    private func handleCardReveal(at index: Int) {
        revealedIndices.insert(index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if currentIndex < cards.count - 1 {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.75)) {
                    currentIndex += 1
                }
            }
        }
    }
    
    private func handleCardTap(at index: Int) {
        if index != currentIndex {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                currentIndex = index
            }
        }
    }
}

// MARK: - Card Item View
private struct CardItemView: View {
    let card: Card
    let index: Int
    let currentIndex: Int
    @Binding var revealedCount: Int
    @Binding var revealedIndices: Set<Int>
    let onRevealCompleted: () -> Void
    let onTap: () -> Void
    
    var body: some View {
        RevealCardItem(
            cardData: card,
            revealedCount: $revealedCount,
            onRevealCompleted: onRevealCompleted,
            forceReveal: revealedIndices.contains(index)
        )
        .aspectRatio(5/7, contentMode: .fit)
        .frame(width: 200)
        .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
        .rotation3DEffect(
            .degrees(rotation),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.5
        )
        .offset(x: offset.x, y: offset.y)
        .scaleEffect(scale)
        .blur(radius: blur)
        .zIndex(zIndex)
        .opacity(opacity)
        .animation(.spring(response: 0.6, dampingFraction: 0.75), value: currentIndex)
        .onTapGesture(perform: onTap)
    }
    
    // MARK: - Calculated Properties
    private var distance: Int {
        abs(index - currentIndex)
    }
    
    private var difference: Double {
        Double(index - currentIndex)
    }
    
    private var offset: (x: CGFloat, y: CGFloat) {
        (CGFloat(index - currentIndex) * 230, 0)
    }
    
    private var scale: CGFloat {
        switch distance {
        case 0: return 1.0
        case 1: return 0.85
        default: return 0.7
        }
    }
    
    private var rotation: Double {
        if difference > 0 {
            return min(difference * 15, 30)
        } else if difference < 0 {
            return max(difference * 15, -30)
        }
        return 0
    }
    
    private var blur: CGFloat {
        switch distance {
        case 0: return 0
        case 1: return 1.5
        default: return 3.0
        }
    }
    
    private var opacity: Double {
        switch distance {
        case 0: return 1.0
        case 1: return 0.8
        default: return 0.0
        }
    }
    
    private var zIndex: Double {
        Double(100 - distance)
    }
}
