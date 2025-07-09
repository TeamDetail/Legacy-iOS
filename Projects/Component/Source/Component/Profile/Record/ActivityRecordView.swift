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
            .padding(.horizontal, 12)
            
            HStack(spacing: 8) {
                Text("시련")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                FloorProgressBar(
                    currentFloor: CGFloat(data.maxFloor),
                    maxFloor: 150
                )
            }
            .padding(.horizontal, 12)
            
            HStack(spacing: 8) {
                Text("탐험")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                ExploreProgressBar(
                    currentCard: 0, //TODO: 이거 추가해야함
                    maxCard: 300
                )
            }
            .padding(.horizontal, 12)
        }
        .padding()
        .background(LegacyColor.Background.netural)
        .clipShape(size: 16)
    }
}
