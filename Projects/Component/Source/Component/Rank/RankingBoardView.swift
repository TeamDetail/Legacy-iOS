//
//  RankingBoardView.swift
//  Component
//
//  Created by 김은찬 on 6/4/25.
//

import SwiftUI
import Shimmer

public struct RankingBoardView: View {
    let lank: String
    let name: String
    let title: String
    let strokeColor: LegacyColorable
    
    public init(lank: String, name: String, title: String, strokeColor: LegacyColorable) {
        self.lank = lank
        self.name = name
        self.title = title
        self.strokeColor = strokeColor
    }
    
    //TODO: 실제 데이터로 수정
    public var body: some View {
        VStack(spacing: 8) {
            Circle()
                .frame(width: 60, height: 60)
                .redacted(reason: .placeholder)
                .shimmering()
            
            Text(lank)
                .font(.title3(.bold))
                .foreground(strokeColor)
            
            Text("999블록")
                .font(.body1(.bold))
                .foreground(LegacyColor.Yellow.normal)
            
            Text(name)
                .font(.body1(.bold))
                .foreground(LegacyColor.Common.white)
            
            TitleBadge(title, color: LegacyColor.Yellow.alternative)
        }
        .padding()
        .background(LegacyColor.Background.normal)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .foreground(strokeColor)
        )
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 12)
    }
}
