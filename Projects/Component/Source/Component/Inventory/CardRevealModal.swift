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
    
    public init(packName: String, cards: [Card], close: @escaping () -> Void) {
        self.packName = packName
        self.cards = cards
        self.close = close
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                Text("카드 획득!")
                    .font(.title2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text("~ \(packName) ~")
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Label.alternative)
            }
            .padding(.top, 32)
            .padding(.bottom, 24)
            
            ZStack {
                ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
                    let offset = calculateOffset(for: index, current: currentIndex)
                    let scale = calculateScale(for: index, current: currentIndex)
                    let zIndex = calculateZIndex(for: index, current: currentIndex)
                    
                    RevealCardItem(
                        cardData: card,
                        revealedCount: $revealedCount,
                        onRevealCompleted: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                if currentIndex < cards.count - 1 {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        currentIndex += 1
                                    }
                                }
                            }
                        }
                    )
                    .aspectRatio(5/7, contentMode: .fit)
                    .frame(width: 200)
                    .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
                    .offset(x: offset)
                    .scaleEffect(scale)
                    .zIndex(zIndex)
                    .opacity(abs(index - currentIndex) <= 1 ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: currentIndex)
                }
            }
            .frame(height: 300)
            .padding(.horizontal, 40)
            .clipped()
            .gesture(
                DragGesture()
                    .onEnded { value in
                        let threshold: CGFloat = 50
                        withAnimation(.easeInOut(duration: 0.3)) {
                            if value.translation.width > threshold && currentIndex > 0 {
                                currentIndex -= 1
                            } else if value.translation.width < -threshold && currentIndex < cards.count - 1 {
                                currentIndex += 1
                            }
                        }
                    }
            )
            
            Text("\(currentIndex + 1) / \(cards.count)")
                .font(.caption1(.medium))
                .foreground(LegacyColor.Label.netural)
                .padding(.top, 24)
                .padding(.bottom, 12)
            
            AnimationButton {
                close()
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
            
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foreground(LegacyColor.Background.normal)
        )
        .padding(.horizontal, 20)
    }
    
    // MARK: - 카드 배치 계산
    private func calculateOffset(for index: Int, current: Int) -> CGFloat {
        let difference = CGFloat(index - current)
        return difference * 230 // 카드 폭과 약간 여유
    }
    
    private func calculateScale(for index: Int, current: Int) -> CGFloat {
        let distance = abs(index - current)
        switch distance {
        case 0: return 1.0
        case 1: return 0.85
        default: return 0.7
        }
    }
    
    private func calculateZIndex(for index: Int, current: Int) -> Double {
        let distance = abs(index - current)
        return Double(cards.count - distance)
    }
}
