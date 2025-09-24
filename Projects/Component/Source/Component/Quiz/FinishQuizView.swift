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
    
    public init(
        data: RuinsDetailResponse,
        onDismiss: @escaping () -> Void
    ) {
        self.data = data
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
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
            }
            .frame(width: 370, height: 640)
            .clipShape(size: 20)
            .padding(.horizontal, 16)
            .background(LegacyColor.Background.normal)
        }
    }
}
