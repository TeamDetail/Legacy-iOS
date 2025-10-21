//
//  CourseDetailClearItem.swift
//  Component
//
//  Created by 김은찬 on 8/29/25.
//

import SwiftUI
import Domain

public struct CourseDetailClearItem: View {
    let data: ClearRuinsResponse
    let index: Int
    
    public init(data: ClearRuinsResponse, index: Int) {
        self.data = data
        self.index = index
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack {
                Text("\(index + 1)")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                    .frame(width: 40, height: 40)
                    .background(data.clear ? LegacyColor.Blue.netural : LegacyColor.Label.alternative)
                    .clipShape(Circle())
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("#\(data.data.ruinsId)")
                    .font(.caption1(.medium))
                    .foreground(LegacyColor.Label.alternative)
                
                Text(data.data.name)
                    .font(.heading1(.bold))
                    .foreground(LegacyColor.Common.white)
                
                DetailRatingInfoItem(data.data)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
            if let card = data.data.card {
                RuinCardView(data: card)
                    .frame(width: 120, height: 168)
            } else {
                ErrorRuinsCardView()
                    .frame(width: 120, height: 168)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
}
