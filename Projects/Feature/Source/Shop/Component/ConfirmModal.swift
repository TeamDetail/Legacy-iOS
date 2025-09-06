//
//  ConfirmModal.swift
//  Feature
//
//  Created by 김은찬 on 9/7/25.
//

import SwiftUI
import Component
import Shared

struct ConfirmModal: View {
    let confirm: () -> Void
    let cancel: () -> Void
    let price: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text("정말 구매하시겠습니까?")
                .font(.heading1(.bold))
                .foreground(LegacyColor.Common.white)
            
            Text(makeConfirmModalText(price))
                .font(.body1(.bold))
                .foreground(LegacyColor.Common.white)
            
            HStack(spacing: 16) {
                Button(action: cancel) {
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
                
                Button(action: confirm) {
                    Text("구매")
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
            .padding(.top, 2)
            .padding(.vertical, 4)
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
