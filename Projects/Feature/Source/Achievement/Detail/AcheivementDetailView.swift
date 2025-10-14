//
//  AcheivementDetailView.swift
//  Feature
//
//  Created by 김은찬 on 9/17/25.
//

import Domain
import FlowKit
import SwiftUI
import Component

struct AcheivementDetailView: View {
    @Flow var flow
    let data: AchievementResponse
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 24), count: 7)
    
    var body: some View {
        VStack(alignment: .center, spacing: 14) {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .foreground(LegacyColor.Purple.normal)
                    .frame(width: 200, height: 200)
                
                HStack(spacing: 6) {
                    Text(data.achievementName)
                        .font(.title2(.bold))
                        .foreground(LegacyColor.Common.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.8)
                    
                    Text("#미션")
                        .font(.title3(.bold))
                        .foreground(LegacyColor.Red.normal)
                }
                
                Text(data.achievementContent)
                    .font(.headline(.regular))
                    .foreground(LegacyColor.Label.alternative)
            }
            
            HStack {
                Text("목표")
                    .font(.label(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
                
                Text("\(data.goalRate)블록 탐험")
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Common.white)
            }
            .padding(.horizontal, 14)
            
            HStack {
                Text("상태")
                    .font(.label(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
                
                Text("\(data.currentRate) / \(data.goalRate)")
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Red.netural)
            }
            .padding(.horizontal, 14)
            
            HStack {
                Text("달성자 비율")
                    .font(.label(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
                
                Text("\(data.achieveUserPercent)%")
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Common.white)
            }
            .padding(.horizontal, 14)
            
            
            HStack {
                Text("보상")
                    .font(.label(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
            }
            .padding(.horizontal, 14)
            
            HStack {
                Spacer()
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(50), spacing: 16), count: data.achievementAward.count),
                    spacing: 16
                ) {
                    ForEach(data.achievementAward, id: \.self) { item in
                        InventoryItem() {}
                    }
                }
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 14)
        .backButton(title: "도전과제 정보") {
            flow.pop()
        }
    }
}
