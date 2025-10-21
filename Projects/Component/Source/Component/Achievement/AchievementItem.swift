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
    let selection: Int
    let action: () -> Void
    
    public init(data: AchievementResponse, selection: Int, action: @escaping () -> Void) {
        self.data = data
        self.selection = selection
        self.action = action
    }
    
    private var categoryText: String {
        switch selection {
        case 0: return "탐험"
        case 1: return "숙련"
        case 2: return "히든"
        default: return ""
        }
    }
    
    private var categoryColor: LegacyColorable {
        switch selection {
        case 0: return LegacyColor.Blue.netural
        case 1: return LegacyColor.Yellow.netural
        case 2: return LegacyColor.Primary.normal
        default: return LegacyColor.Red.normal
        }
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            HStack {
                ZStack {
                    Image(icon: data.achievementGrade.icon)
                        .resizable()
                        .frame(width: 64, height: 64)
                    
                    Image(icon: data.achievementType.icon)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 6) {
                            Text(data.achievementName)
                                .font(.label(.bold))
                                .foreground(LegacyColor.Common.white)
                            Text("#\(categoryText)")
                                .font(.caption1(.medium))
                                .foreground(categoryColor)
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
                            
                            Text(data.achievementGradeText)
                                .font(.caption1(.extraBold))
                                .foreground(LegacyColor.Label.normal)
                                .lineLimit(1)
                                .minimumScaleFactor(1.0)
                                .truncationMode(.tail)
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
