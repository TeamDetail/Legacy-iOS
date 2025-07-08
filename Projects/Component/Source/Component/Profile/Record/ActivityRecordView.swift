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
            HStack {
                Text("숙련")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Spacer()
                
                LevelProgressBar(
                    level: data.level,
                    currentExp: CGFloat(data.exp),
                    maxExp: 13000
                )
                .frame(width: 300, height: 40)
            }
            .padding(.horizontal, 14)
            
            HStack {
                Text("시련")
                
                //TODO: 시련 ProgressBar
            }
            .padding(.horizontal, 14)
            
            HStack {
                Text("탐험")
                
                //TODO: 탐험 ProgressBar
            }
            .padding(.horizontal, 14)
        }
        .padding()
        .background(LegacyColor.Fill.normal)
        .clipShape(size: 16)
    }
}
