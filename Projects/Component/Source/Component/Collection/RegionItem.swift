//
//  RegionItem.swift
//  Component
//
//  Created by 김은찬 on 7/24/25.
//

import SwiftUI

public struct RegionItem: View {
    let regionType: RegionEnum
    let cardLength: Int
    let select: Bool
    let action: () -> Void
    
    public init(
        regionType: RegionEnum,
        cardLength: Int,
        select: Bool,
        action: @escaping () -> Void
    ) {
        self.regionType = regionType
        self.cardLength = cardLength
        self.select = select
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            HStack(alignment: .center, spacing: 30) {
                Text(regionType.regionName)
                    .font(.body2(.bold))
                    .foreground(LegacyColor.Common.white)
                    .padding(2)
                
                HStack {
                    Text("\(cardLength) / 80")
                        .font(.caption2(.medium))
                        .foreground(cardLength == 50 ? LegacyColor.Yellow.netural : LegacyColor.Common.white)
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 6)
                .background(select ? LegacyColor.Primary.alternative : LegacyColor.Background.normal)
                .clipShape(size: 8)
            }
            .padding(4)
            .frame(width: 120, height: 32, alignment: .center)
            .background(select ? LegacyColor.Primary.normal : LegacyColor.Background.normal)
            .clipShape(size: 8)
        }
    }
}
