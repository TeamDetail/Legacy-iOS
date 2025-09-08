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
    public init(data: ClearRuinsResponse) {
        self.data = data
    }
    public var body: some View {
        HStack {
            VStack {
                Text(data.clear ? "✓" : "✗")
                    .font(.heading2(.bold))
                    .foreground(LegacyColor.Common.white)
                    .frame(width: 40, height: 40)
                    .background(data.clear ? LegacyColor.Green.normal : LegacyColor.Label.alternative)
                    .clipShape(size: 999)
                Spacer()
            }
            .padding(.vertical, 4)
            
            VStack(alignment: .leading, spacing: 14) {
                Text("#\(data.data.ruinsId)")
                    .font(.caption1(.medium))
                    .foreground(LegacyColor.Label.alternative)
                
                Text(data.data.name)
                    .font(.heading1(.bold))
                    .foreground(LegacyColor.Common.white)
                
                DetailRatingInfoItem()
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
    }
}
