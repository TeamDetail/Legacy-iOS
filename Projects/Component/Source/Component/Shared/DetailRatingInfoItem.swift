//
//  DetailRatingInfoItem.swift
//  Component
//
//  Created by 김은찬 on 8/29/25.
//

import SwiftUI
import Domain

public struct DetailRatingInfoItem: View {
    let data: RuinsDetailResponse
    public init(_ data: RuinsDetailResponse) {
        self.data = data
    }
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                ForEach(0..<5, id: \.self) { index in
                    HStack(spacing: 0) {
                        Image(icon: .leftStar)
                            .resizable()
                            .frame(width: 7, height: 13)
                            .foreground(
                                data.averageRating >= Double(index) + 0.5
                                ? LegacyColor.Primary.normal
                                : LegacyColor.Common.white
                            )
                        
                        Image(icon: .rightStar)
                            .resizable()
                            .frame(width: 7, height: 13)
                            .foreground(
                                data.averageRating >= Double(index) + 1.0
                                ? LegacyColor.Primary.normal
                                : LegacyColor.Common.white
                            )
                    }
                }
                .foreground(LegacyColor.Primary.normal)
                
                Text("( \(data.countComments) )")
                    .font(.caption2(.medium))
                    .foreground(LegacyColor.Fill.alternative)
                
                Spacer()
            }
            
            LegacyDivider()
            
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("탐험자 수")
                        .font(.caption2(.regular))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text("\(data.countComments)명")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Label.normal)
                }
                
                VStack(alignment: .leading) {
                    Text("평균 평점")
                        .font(.caption2(.regular))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text("\(String(format: "%.1f", data.averageRating))점")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Label.normal)
                }
                
                Spacer()
            }
        }
    }
}
