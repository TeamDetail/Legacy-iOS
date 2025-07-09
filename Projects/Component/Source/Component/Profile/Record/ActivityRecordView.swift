//
//  ActivityRecordView.swift
//  Component
//
//  Created by 김은찬 on 7/8/25.
//

import SwiftUI
import Domain

public struct ActivityRecordView: View {
    let data: UserInfoResponse
    
    public init(data: UserInfoResponse) {
        self.data = data
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                Text("숙련")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
                
                LevelProgressBar(
                    level: data.level,
                    currentExp: CGFloat(data.exp),
                    maxExp: 13000
                )
            }
            .padding(.leading, 8)
            
            HStack(spacing: 8) {
                Text("시련")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
                
                FloorProgressBar(
                    currentFloor: CGFloat(data.maxFloor),
                    maxFloor: 150
                )
            }
            .padding(.leading, 8)
            
            HStack(spacing: 8) {
                Text("탐험")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
                
                ExploreProgressBar(
                    currentCard: 0, //TODO: 이거 추가해야함
                    maxCard: 300
                )
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .background(LegacyColor.Background.netural)
        .clipShape(size: 16)
        
        VStack(spacing: 8) {
            RecordItem(
                data: data.maxScore,
                recordType: .maxScore
            )
            
            RecordItem(
                data: data.allBlocks,
                recordType: .allBlocks
            )
            
            RecordItem(
                data: data.ruinsBlocks,
                recordType: .ruinsBlocks
            )
        }
        .padding(.top, 6)
    }
}
