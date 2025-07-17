//
//  FinishQuizView.swift
//  Component
//
//  Created by 김은찬 on 7/17/25.
//

import Kingfisher
import SwiftUI
import Shimmer
import Domain

public struct FinishQuizView: View {
    public let data: RuinsDetailResponse
    let onDismiss: () -> Void
    
    @State private var isShaking = false
    @State private var shakePhase = 0
    
    public init(
        data: RuinsDetailResponse,
        onDismiss: @escaping () -> Void
    ) {
        self.data = data
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            VStack {
                Spacer()
                
                if let url = URL(string: data.ruinsImage) {
                    ZStack(alignment: .init(horizontal: .leading, vertical: .bottom)) {
                        KFImage(url)
                            .placeholder { _ in
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 200, height: 280)
                                    .redacted(reason: .placeholder)
                                    .shimmering()
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 280)
                            .clipShape(size: 20)
                        
                        Text(data.name)
                            .font(.bitFont(size: 14))
                            .foreground(LegacyColor.Common.white)
                            .padding(12)
                            .clipShape(size: 20)
                    }
                    .padding(4)
                    .overlay(
                        RuinsCategory(
                            category: data.category
                        )
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding([.leading, .top], 12),
                        alignment: .topLeading
                    )
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
                
                Text("카드를 획득했어요!")
                    .font(.title2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
            }
        }
        .onDisappear {
            stopShaking()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                onDismiss()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
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
