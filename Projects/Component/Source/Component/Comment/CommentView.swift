//
//  CommentView.swift
//  Component
//
//  Created by 김은찬 on 8/21/25.
//

import SwiftUI
import Domain

public struct CommentView: View {
    @State private var commentText = ""
    let data: RuinsDetailResponse
    
    public init(_ data: RuinsDetailResponse) {
        self.data = data
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("한줄평 남기기")
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Text("#\(data.ruinsId)")
                        .font(.caption1(.medium))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text(data.name)
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Label.normal)
                }
                
                HStack(spacing: 6) {
                    ForEach(1...5, id: \.self) { _ in
                        HStack(spacing: 0) {
                            Image(icon: .leftStar)
                            Image(icon: .rightStar)
                        }
                    }
                    .foreground(LegacyColor.Common.white)
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(8)
            
            CommentField(commentText: $commentText)
            
            AnimationButton {
                
            } label: {
                Text("작성 완료!")
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
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
            .padding(.bottom, 8)
        }
        .padding(10)
        .background(LegacyColor.Background.netural)
        .clipShape(size: 24)
        .shadow(radius: 10)
        .padding(.horizontal, 4)
    }
}
