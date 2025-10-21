//
//  CommentModal.swift
//  Component
//
//  Created by 김은찬 on 8/21/25.
//

import SwiftUI

public struct CommentModal: View {
    @Binding var rating: Double
    @State private var tempRating: Double
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    public init(
        _ rating: Binding<Double>,
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) {
        self._rating = rating
        self._tempRating = State(initialValue: rating.wrappedValue)
        self.onConfirm = onConfirm
        self.onCancel = onCancel
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text(String(format: "%.1f", tempRating))
                .font(.title2(.bold))
                .foreground(LegacyColor.Primary.normal)
            
            HStack(spacing: 6) {
                ForEach(0..<5, id: \.self) { index in
                    HStack(spacing: 0) {
                        Image(icon: .leftStar)
                            .foreground(tempRating >= Double(index) + 0.5 ? LegacyColor.Primary.normal : LegacyColor.Common.white)
                            .onTapGesture {
                                tempRating = Double(index) + 0.5
                            }
                        
                        Image(icon: .rightStar)
                            .foreground(tempRating >= Double(index) + 1.0 ? LegacyColor.Primary.normal : LegacyColor.Common.white)
                            .onTapGesture {
                                tempRating = Double(index) + 1.0
                            }
                    }
                }
            }
            
            Text("별점을 선택해주세요.")
                .font(.caption1(.medium))
                .foreground(LegacyColor.Label.alternative)
            
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
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Line.alternative)
                        )
                }
                
                AnimationButton {
                    rating = tempRating
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
                                .inset(by: 5)
                                .stroke(lineWidth: 1)
                                .foreground(LegacyColor.Purple.normal)
                        )
                }
            }
            .frame(width: 336)
        }
        .frame(width: 370, height: 190)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
    }
}

