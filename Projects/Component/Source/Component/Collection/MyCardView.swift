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

public struct MyCardView: View {
    let data: CardResponse
    @State private var isShaking = false
    @State private var shakePhase = 0
    
    public init(data: CardResponse) {
        self.data = data
    }
    
    public var body: some View {
        if let url = URL(string: data.cardImageUrl) {
            ZStack(alignment: .init(horizontal: .leading, vertical: .bottom)) {
                KFImage(url)
                    .placeholder { _ in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 120, height: 168)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 168)
                    .clipShape(size: 12)
                
                Text(data.cardName)
                    .font(.bitFont(size: 14))
                    .foreground(LegacyColor.Common.white)
                    .padding(8)
                    .clipShape(size: 20)
            }
            .padding(4)
            .overlay(
                VStack(spacing: 4) {
                    CardCategory(category: data.nationAttributeName, backgroundColor: LegacyColor.Primary.normal)
                    CardCategory(category: data.lineAttributeName, backgroundColor: LegacyColor.Blue.netural)
                    CardCategory(category: data.regionAttributeName, backgroundColor: LegacyColor.Red.netural)
                }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding([.leading, .top], 10), alignment: .topLeading)
            .padding(.vertical, 8)
            
            .rotationEffect(Angle(degrees: rotationDegree(for: shakePhase)))
            .scaleEffect(isShaking ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.12), value: shakePhase)
            .animation(.easeInOut(duration: 0.12), value: isShaking)
            .onTapGesture {
                guard !isShaking else { return }
                isShaking = true
                shakePhase = 0
                startShaking()
            }
        }
    }
    
    func rotationDegree(for phase: Int) -> Double {
        switch phase % 4 {
        case 0: return 0
        case 1: return -0.5
        case 2: return 0.5
        case 3: return 0
        default: return 0
        }
    }
    
    @State private var shakeTimer: Timer?
    
    func startShaking() {
        shakeTimer = Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { _ in
            withAnimation {
                shakePhase += 1
            }
        }
        delayRun(1) {
            stopShaking()
        }
    }
    
    func stopShaking() {
        shakeTimer?.invalidate()
        shakeTimer = nil
        withAnimation {
            isShaking = false
            shakePhase = 0
        }
    }
}
