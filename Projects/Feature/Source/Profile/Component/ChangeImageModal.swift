//
//  ChangeImageModal.swift
//  Feature
//
//  Created by 김은찬 on 8/29/25.
//

import SwiftUI
import Component

//MARK: 삭제
struct ChangeImageModal: View {
    let changeImage: () -> Void
    let resetImage: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            AnimationButton {
                changeImage()
            } label: {
                Text("프로필 이미지 변경")
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Common.white)
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
                resetImage()
            } label: {
                Text("이미지 초기화")
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Red.netural)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Red.netural)
                    )
            }
        }
        .frame(width: 280)
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 16)
        .scaleEffect(1.0)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: true)
    }
}
