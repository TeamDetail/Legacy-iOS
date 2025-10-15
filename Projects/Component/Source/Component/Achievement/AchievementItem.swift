//
//  AchievementView.swift
//  Component
//
//  Created by 김은찬 on 8/19/25.
//

import SwiftUI
import Domain

public struct AchievementItem: View {
    let data: AchievementResponse
    let action: () -> Void
    
    public init(data: AchievementResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .foreground(LegacyColor.Purple.normal)
                    .frame(width: 64, height: 64)
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 6) {
                            Text(data.achievementName)
                                .font(.label(.bold))
                                .foreground(LegacyColor.Common.white)
                            Text("#\(data.achievementType)")
                                .font(.caption1(.medium))
                                .foreground(LegacyColor.Red.normal)
                        }
                        Text(data.achievementContent)
                            .font(.caption2(.medium))
                            .foreground(LegacyColor.Label.alternative)
                    }
                    
                    HStack(spacing: 8) {
                        HStack(spacing: 4) {
                            Text("목표")
                                .font(.caption1(.regular))
                                .foreground(LegacyColor.Label.netural)
                            
                            Text("\(data.goalRate)블록 탐험")
                                .font(.caption1(.extraBold))
                                .foreground(LegacyColor.Label.normal)
                        }
                        
                        HStack(spacing: 4) {
                            Text("현재상태")
                                .font(.caption1(.regular))
                                .foreground(LegacyColor.Label.netural)
                            
                            Text("\(data.currentRate) / \(data.goalRate)")
                                .font(.caption1(.extraBold))
                                .foreground(LegacyColor.Label.normal)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
