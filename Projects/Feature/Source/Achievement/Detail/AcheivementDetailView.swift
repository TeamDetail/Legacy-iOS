//
//  AchievementDetailView.swift
//  Feature
//
//  Created by 김은찬 on 9/17/25.
//

import Domain
import FlowKit
import SwiftUI
import Component

struct AchievementDetailView: View {
    @Flow var flow
    let data: AchievementResponse
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 14) {
                VStack(spacing: 8) {
                    ZStack {
                        Image(icon: data.achievementGrade.icon)
                            .resizable()
                            .frame(width: 200, height: 200)
                        
                        Image(icon: data.achievementType.icon)
                            .resizable()
                            .frame(width: 120, height: 120)
                    }
                    .padding(.horizontal, 4)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(data.achievementName)
                            .font(.title2(.bold))
                            .foreground(LegacyColor.Common.white)
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.9)
                            .layoutPriority(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 8)
                    
                    
                    Text(data.achievementContent)
                        .font(.headline(.regular))
                        .foreground(LegacyColor.Label.alternative)
                }
                
                VStack(spacing: 16) {
                    HStack {
                        Text("목표")
                            .font(.body1(.regular))
                            .foreground(LegacyColor.Label.netural)
                        
                        Spacer()
                        
                        Text("\(data.achievementGradeText)")
                            .font(.body1(.bold))
                            .foreground(LegacyColor.Common.white)
                            .lineLimit(2)
                            .multilineTextAlignment(.trailing)
                            .minimumScaleFactor(0.7)
                    }
                    .padding(.vertical, 8)
                    
                    HStack {
                        Text("상태")
                            .font(.body1(.regular))
                            .foreground(LegacyColor.Label.netural)
                        
                        Spacer()
                        
                        Text("\(data.currentRate) / \(data.goalRate)")
                            .font(.body1(.bold))
                            .foreground(LegacyColor.Red.netural)
                    }
                    
                    HStack {
                        Text("달성자 비율")
                            .font(.body1(.regular))
                            .foreground(LegacyColor.Label.netural)
                        
                        Spacer()
                        
                        Text("\(data.achieveUserPercent)%")
                            .font(.body1(.bold))
                            .foreground(LegacyColor.Common.white)
                    }
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("보상")
                                .font(.headline(.medium))
                                .foreground(LegacyColor.Label.netural)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("크레딧")
                                .font(.label(.bold))
                                .foreground(LegacyColor.Common.white)
                            
                            Spacer()
                            
                            Text("30000 크레딧")
                                .font(.body2(.medium))
                                .foreground(LegacyColor.Label.alternative)
                        }
                        
                        HStack {
                            Text("경험치")
                                .font(.label(.bold))
                                .foreground(LegacyColor.Common.white)
                            
                            Spacer()
                            
                            Text("2000 exp")
                                .font(.body2(.medium))
                                .foreground(LegacyColor.Label.alternative)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    HStack {
                        Text(data.achievementAward.first?.itemName ?? "카드팩")
                            .font(.label(.medium))
                            .foreground(LegacyColor.Common.white)
                        
                        Spacer()
                        
                        InventoryItem() {}
                            .overlay(alignment: .bottomTrailing) {
                                Text("\(data.achievementAward.count)")
                                    .font(.system(size: 12).bold())
                                    .foreground(LegacyColor.Common.white)
                                    .padding(4)
                            }
                    }
                }
                .padding(.horizontal, 8)
                
                Spacer()
            }
        }
        .padding(.horizontal, 14)
        .backButton(title: "도전과제 정보") {
            flow.pop()
        }
    }
}
