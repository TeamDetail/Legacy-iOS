//
//  MailRewardsView.swift
//  Component
//
//  Created by 김은찬 on 9/15/25.
//

import SwiftUI
import Domain

public struct MailRewardsView: View {
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)
    
    let data: [MailResponse]
    let close: () -> Void
    
    @State private var isVisible = false
    @State private var itemsAnimated = false
    
    public init(data: [MailResponse], close: @escaping () -> Void) {
        self.data = data
        self.close = close
    }
    
    public var body: some View {
        VStack(spacing: 14) {
            VStack(spacing: 8) {
                Text("우편함 보상 획득!")
                    .font(.title3(.bold))
                    .foreground(LegacyColor.Common.white)
                    .scaleEffect(isVisible ? 1.0 : 0.8)
                    .opacity(isVisible ? 1.0 : 0.0)
                
                Text("우편함의 모든 보상을 수령했어요.")
                    .font(.caption1(.medium))
                    .foreground(LegacyColor.Label.alternative)
                    .opacity(isVisible ? 1.0 : 0.0)
            }
            .padding(.top, 28)
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isVisible)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(Array(data.enumerated()), id: \.offset) { dataIndex, mailData in
                    ForEach(Array(mailData.itemData.enumerated()), id: \.offset) { itemIndex, item in
                        MailboxView()
                            .scaleEffect(itemsAnimated ? 1.0 : 0.1)
                            .opacity(itemsAnimated ? 1.0 : 0.0)
                            .animation(
                                .spring(response: 0.4, dampingFraction: 0.7)
                                .delay(Double(dataIndex * mailData.itemData.count + itemIndex) * 0.1),
                                value: itemsAnimated
                            )
                    }
                }
            }
            .padding(.top, 12)
            .padding(.horizontal, 16)
            .padding(.bottom, 60)
            Spacer()
        }
        .overlay(alignment: .bottom) {
            AnimationButton {
                close()
            } label: {
                Text("돌아가기")
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
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
            .padding(.bottom, 10)
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 520)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 20)
        .padding(16)
        .opacity(isVisible ? 1.0 : 0.0)
        .scaleEffect(isVisible ? 1.0 : 0.95)
        .animation(.easeInOut(duration: 0.4), value: isVisible)
        .onAppear {
            withAnimation {
                isVisible = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                itemsAnimated = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isVisible = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    close()
                }
            }
        }
    }
}
