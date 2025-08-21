//
//  CommentModal.swift
//  Component
//
//  Created by 김은찬 on 8/21/25.
//

import SwiftUI

public struct CommentModal: View {
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    public init(onConfirm: @escaping () -> Void, onCancel: @escaping () -> Void) {
        self.onConfirm = onConfirm
        self.onCancel = onCancel
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Text("1")
                .font(.title2(.bold))
                .foreground(LegacyColor.Primary.normal)
            
            HStack(spacing: 6) {
                ForEach(1...5, id: \.self) { _ in
                    HStack(spacing: 0) {
                        Image(icon: .leftStar)
                        Image(icon: .rightStar)
                    }
                }
                .foreground(LegacyColor.Common.white)
            }
            
            Text("클릭해서 별점 선택해주세요.")
                .font(.caption1(.medium))
                .foreground(LegacyColor.Label.alternative)
            
            HStack(spacing: 8) {
                AnimationButton {
                    onConfirm()
                } label: {
                    HStack {
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
                    }
                }
                
                AnimationButton {
                    onCancel()
                } label: {
                    HStack {
                        Text("최소")
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
                }
            }
            .frame(width: 336)
        }
        .frame(width: 370, height: 190)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
    }
}
