//
//  ActivityRecordView.swift
//  Feature
//
//  Created by 김은찬 on 9/17/25.
//

import Domain
import Shared
import SwiftUI
import Component

struct ActivityRecordView: View {
    let data: UserInfoResponse
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                HStack {
                    Text("자기소개")
                        .font(.label(.bold))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    Text(data.description.isEmpty ? "자기소개가 없어요" : data.description)
                        .font(.headline(.bold))
                        .foreground(LegacyColor.Common.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(LegacyColor.Fill.normal)
                .clipShape(size: 8)
            }
            
            VStack(spacing: 14) {
                HStack {
                    Text("숙련")
                        .font(.title3(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Spacer()
                    
                    Text(rankText(data.record.experience.rank))
                        .font(.title3(.bold))
                        .foreground(LegacyColor.Red.normal)
                }
                LevelProgressBar(
                    level: data.level,
                    currentExp: 7000,
                    maxExp: 13000
                )
                
                AdventureRecordSection(
                    record: data.record
                )
            }
            
            VStack(spacing: 14) {
                HStack {
                    Text("탐험")
                        .font(.title3(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Spacer()
                    
                    Text(rankText(data.record.experience.rank))
                        .font(.title3(.bold))
                        .foreground(LegacyColor.Blue.netural)
                }
                
                AdventureProgressBar(bloackCount: data.record.adventure.allBlocks)
                
                ExperienceRecordSection(
                    record: data.record
                )
            }
        }
        .padding(.bottom, 6)
    }
}
