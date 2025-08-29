//
//  MyCardView.swift
//  Component
//
//  Created by 김은찬 on 7/24/25.
//

import Kingfisher
import SwiftUI
import Shimmer
import Domain

public struct RuinCardView: View {
    let data: Card
    @State private var isShaking = false
    @State private var shakePhase = 0
    @State private var shakeTimer: Timer?
    
    public init(data: Card) {
        self.data = data
    }
    
    public var body: some View {
        if let url = URL(string: data.cardImageUrl) {
            ZStack(alignment: .topLeading) {
                KFImage(url)
                    .placeholder { _ in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.3))
                            .frame(maxWidth: .infinity)
                            .aspectRatio(140/196, contentMode: .fit)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    .resizable()
                    .aspectRatio(140/196, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipShape(size: 12)
                
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.black.opacity(0.0), location: 0.4),
                        .init(color: Color.black.opacity(0.8), location: 0.7),
                        .init(color: Color.black.opacity(1.0), location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(size: 12)
                
                VStack(alignment: .leading, spacing: 4) {
                    CardCategory(category: data.nationAttributeName, backgroundColor: LegacyColor.Primary.normal)
                    CardCategory(category: data.lineAttributeName, backgroundColor: LegacyColor.Blue.netural)
                    CardCategory(category: data.regionAttributeName, backgroundColor: LegacyColor.Red.netural)
                    
                    Spacer()
                    
                    Text(data.cardName)
                        .font(.bitFont(size: 16))
                        .foreground(LegacyColor.Common.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .padding(8)
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(140/196, contentMode: .fit)
            .rotationEffect(Angle(degrees: rotationDegree(for: shakePhase)))
            .scaleEffect(isShaking ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.12), value: shakePhase)
            .animation(.easeInOut(duration: 0.12), value: isShaking)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 2)
                    .foreground(LegacyColor.Line.netural)
            )
            .onTapGesture {
                guard !isShaking else { return }
                isShaking = true
                shakePhase = 0
                startShaking()
            }
        }
    }
    
    private func rotationDegree(for phase: Int) -> Double {
        switch phase % 4 {
        case 0: return 0
        case 1: return -0.5
        case 2: return 0.5
        case 3: return 0
        default: return 0
        }
    }
    
    private func startShaking() {
        shakeTimer = Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { _ in
            withAnimation {
                shakePhase += 1
            }
        }
        delayRun(1) {
            stopShaking()
        }
    }
    
    private func stopShaking() {
        shakeTimer?.invalidate()
        shakeTimer = nil
        withAnimation {
            isShaking = false
            shakePhase = 0
        }
    }
}
