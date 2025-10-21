//
//  CountModal.swift
//  Component
//
//  Created by 김은찬 on 9/16/25.
//

import SwiftUI

public struct CountModal: View {
    @Binding var count: Int
    let maxCount: Int
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    @State private var isAppeared: Bool = false
    @State private var numberScale: CGFloat = 1.0
    
    public init(
        count: Binding<Int>,
        maxCount: Int,
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) {
        self._count = count
        self.maxCount = maxCount
        self.onConfirm = onConfirm
        self.onCancel = onCancel
    }
    
    public var body: some View {
        VStack(spacing: 14) {
            Text("사용할 개수 선택")
                .font(.heading1(.bold))
                .foreground(LegacyColor.Common.white)
                .padding(.top, 14)
                .opacity(isAppeared ? 1 : 0)
                .offset(y: isAppeared ? 0 : -10)
                .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.1), value: isAppeared)
            
            HStack(spacing: 12) {
                AnimationButton {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        if count > 1 {
                            count -= 1
                            triggerNumberPulse(scale: 0.85)
                        }
                    }
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.title2.bold())
                        .foreground(count > 1 ? LegacyColor.Common.white : LegacyColor.Label.assistive)
                        .frame(width: 59, height: 59)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Line.alternative)
                        )
                        .scaleEffect(count > 1 ? 1.0 : 0.95)
                }
                .disabled(count <= 1)
                
                Text("\(count)")
                    .font(.title1(.bold))
                    .foreground(LegacyColor.Common.white)
                    .frame(width: 100, height: 59)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Line.alternative)
                    )
                    .scaleEffect(numberScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: numberScale)
                
                AnimationButton {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        if count < maxCount {
                            count += 1
                            triggerNumberPulse(scale: 1.15)
                        }
                    }
                } label: {
                    Image(systemName: "chevron.up")
                        .font(.title2.bold())
                        .foreground(count < maxCount ? LegacyColor.Common.white : LegacyColor.Label.assistive)
                        .frame(width: 59, height: 59)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Line.alternative)
                        )
                        .scaleEffect(count < maxCount ? 1.0 : 0.95)
                }
                .disabled(count >= maxCount)
            }
            .padding(.vertical, 14)
            .opacity(isAppeared ? 1 : 0)
            .scaleEffect(isAppeared ? 1 : 0.9)
            .animation(.spring(response: 0.6, dampingFraction: 0.75).delay(0.15), value: isAppeared)
            
            HStack(spacing: 8) {
                AnimationButton {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        onCancel()
                    }
                } label: {
                    Text("취소")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .font(.caption1(.bold))
                        .foreground(LegacyColor.Label.assistive)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Line.alternative)
                        )
                }
                
                AnimationButton {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        onConfirm()
                    }
                } label: {
                    Text("확인")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .font(.caption1(.bold))
                        .foreground(LegacyColor.Purple.normal)
                        .background(LegacyColor.Fill.normal)
                        .clipShape(size: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Purple.normal)
                        )
                        .scaleEffect(count > 0 ? 1.0 : 0.95)
                        .opacity(count > 0 ? 1.0 : 0.6)
                }
                .disabled(count == 0)
            }
            .frame(width: 240)
            .padding(.bottom, 14)
            .opacity(isAppeared ? 1 : 0)
            .offset(y: isAppeared ? 0 : 10)
            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.25), value: isAppeared)
        }
        .frame(width: 280, height: 240)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
        .scaleEffect(isAppeared ? 1 : 0.92)
        .opacity(isAppeared ? 1 : 0)
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: isAppeared)
        .onAppear {
            count = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                isAppeared = true
            }
        }
    }
    
    private func triggerNumberPulse(scale: CGFloat) {
        numberScale = scale
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            numberScale = 1.0
        }
    }
}
