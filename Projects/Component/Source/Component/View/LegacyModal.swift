//
//  LegacyModal.swift
//  Component
//
//  Created by 김은찬 on 10/6/25.
//

import SwiftUI

public struct LegacyModal: View {
    let title: String
    let description: String
    let confirm: () -> Void
    let cancel: () -> Void
    
    public init(title: String, description: String, confirm: @escaping () -> Void, cancel: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.confirm = confirm
        self.cancel = cancel
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 10) {
                Text(title)
                    .font(.heading1(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text(description)
                    .font(.body2(.medium))
                    .foreground(LegacyColor.Label.netural)
            }
            
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
        }
        .frame(width: 280)
        .padding(20)
        .background(LegacyColor.Background.netural)
        .clipShape(size: 16)
        .scaleEffect(1.0)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: true)
    }
}

