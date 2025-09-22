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
            
            HStack(spacing: 12) {
                AnimationButton {
                    if count > 1 {
                        count -= 1
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
                                .inset(by: 0.5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Line.alternative)
                        )
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
                            .inset(by: 0.5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Line.alternative)
                    )
                
                AnimationButton {
                    if count < maxCount {
                        count += 1
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
                                .inset(by: 0.5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Line.alternative)
                        )
                }
                .disabled(count >= maxCount)
            }
            .padding(.vertical, 14)
            
            HStack(spacing: 8) {
                AnimationButton {
                    onCancel()
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
                                .inset(by: 0.5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Line.alternative)
                        )
                }
                
                AnimationButton {
                    onConfirm()
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
                                .inset(by: 0.5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Purple.normal)
                        )
                }
            }
            .frame(width: 240)
            .padding(.bottom, 14)
        }
        .frame(width: 280, height: 240)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
        .onAppear {
            count = 0
        }
    }
}
