//
//  RankingBoardView.swift
//  Component
//
//  Created by 김은찬 on 6/4/25.
//

import SwiftUI

public struct RankingBoardView: View {
    public init(){}
    //TODO: 수정
    public var body: some View {
        VStack(spacing: 8) {
            Image("penguin")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            Text("1위")
                .font(.title3(.bold))
                .foreground(LegacyColor.Purple.normal)
            
            Text("999층")
                .font(.body1(.bold))
                .foreground(LegacyColor.Yellow.normal)
            
            Text("김민규")
                .font(.body1(.bold))
                .foregroundColor(.white)
            
            TitleBadge("자본주의", color: LegacyColor.Purple.normal)
        }
        .padding()
        .background(LegacyColor.Background.normal)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .foreground(LegacyColor.Purple.normal)
        )
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 150)
    }
}

#Preview {
    RankingBoardView()
}
