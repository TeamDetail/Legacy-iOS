//
//  AchievementView.swift
//  Component
//
//  Created by 김은찬 on 8/19/25.
//

import SwiftUI

public struct AchievementView: View {
    //TODO: data response 추가
    public init() {}
    public var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .foreground(LegacyColor.Purple.normal)
                .frame(width: 64, height: 64)
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 2) {
                        Text("오늘의 탐색 작업")
                            .font(.label(.bold))
                            .foreground(LegacyColor.Common.white)
                        Text("#탐색")
                            .font(.caption1(.medium))
                            .foreground(LegacyColor.Red.normal)
                    }
                    Text("매일매일 하는 게 제일 중요합니다.")
                        .font(.caption2(.medium))
                        .foreground(LegacyColor.Label.alternative)
                }
                
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Text("목표")
                            .font(.caption1(.regular))
                            .foreground(LegacyColor.Label.netural)
                        
                        Text("5블록 탐험")
                            .font(.caption1(.extraBold))
                            .foreground(LegacyColor.Label.normal)
                    }
                    
                    HStack(spacing: 4) {
                        Text("현재상태")
                            .font(.caption1(.regular))
                            .foreground(LegacyColor.Label.netural)
                        
                        Text("0 / 5")
                            .font(.caption1(.extraBold))
                            .foreground(LegacyColor.Label.normal)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AchievementView()
}
