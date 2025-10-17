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
    
    @State private var showStoryUpload = false
    
    public init(
        data: RuinsDetailResponse,
        onDismiss: @escaping () -> Void
    ) {
        self.data = data
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        ZStack {
            LegacyModalView(onDismiss) {
                VStack(spacing: 20) {
                    Spacer()
                    
                    if let cardData = data.card {
                        RuinCardView(data: cardData)
                            .frame(width: 200, height: 280)
                    } else {
                        ErrorRuinsCardView()
                            .frame(width: 200, height: 280)
                    }
                    
                    Text("카드를 획득했어요!")
                        .font(.title2(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        AnimationButton {
                            if data.card != nil {
                                showStoryUpload = true
                            }
                        } label: {
                            Text("스토리 업로드")
                                .frame(width: 157, height: 40)
                                .font(.caption1(.bold))
                                .foreground(LegacyColor.Blue.netural)
                                .background(LegacyColor.Fill.normal)
                                .clipShape(size: 12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .inset(by: 5)
                                        .stroke(lineWidth: 1)
                                        .foreground(LegacyColor.Blue.netural)
                                )
                        }
                        .disabled(data.card == nil)
                        
                        AnimationButton {
                            onDismiss()
                        } label: {
                            Text("나가기")
                                .frame(width: 157, height: 40)
                                .font(.caption1(.bold))
                                .foreground(LegacyColor.Label.alternative)
                                .background(LegacyColor.Fill.normal)
                                .clipShape(size: 12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .inset(by: 5)
                                        .stroke(lineWidth: 1)
                                        .foreground(LegacyColor.Line.netural)
                                )
                        }
                    }
                    .padding(.bottom, 12)
                }
                .frame(width: 370, height: 640)
                .clipShape(size: 20)
                .padding(.horizontal, 16)
                .background(LegacyColor.Background.normal)
            }
            
            if showStoryUpload, let cardData = data.card {
                StoryUploadView(
                    data: cardData,
                    shouldAutoCapture: true,
                    onComplete: {
                        showStoryUpload = false
                    }
                )
                .opacity(0)
                .frame(width: 0, height: 0)
            }
        }
    }
}
