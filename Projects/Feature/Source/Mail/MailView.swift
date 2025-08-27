//
//  MailView.swift
//  Feature
//
//  Created by 김은찬 on 8/27/25.
//

import SwiftUI
import Component

struct MailView: View {
    let onClose: () -> Void
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Image(icon: .mail)
                Text("우편함")
                    .font(.bitFont(size: 28))
                
                Spacer()
                
                AnimationButton {
                    onClose()
                } label: {
                    Image(icon: .close)
                }
            }
            .foreground(LegacyColor.Common.white)
            .padding(.top, 18)
            .padding(.horizontal, 18)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(1...6, id: \.self) { _ in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("5월 10일 점검 보상")
                                .font(.body1(.bold))
                                .foreground(LegacyColor.Common.white)
                            
                            Text("2025. 05. 11.")
                                .font(.caption2(.regular))
                                .foreground(LegacyColor.Label.alternative)
                            
                            HStack(spacing: 12) {
                                ForEach(1...6, id: \.self) { _ in
                                    MailboxView()
                                }
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 60)
        }
        .overlay(alignment: .bottom) {
            AnimationButton {
                //TODO: 서버통신 구현
            } label: {
                Text("일괄 수령")
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Yellow.netural)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Yellow.netural)
                    )
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 18)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 520)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
        .padding(16)
    }
}
