//
//  RuinsSearchItem.swift
//  Feature
//
//  Created by 김은찬 on 9/13/25.
//

import SwiftUI
import Component
import Domain

struct RuinsSearchResultItem: View {
    let data: RuinsDetailResponse
    let action: () -> Void
    var body: some View {
        AnimationButton {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 2) {
                Text("#\(data.ruinsId)")
                    .font(.caption1(.medium))
                    .foreground(LegacyColor.Label.alternative)
                
                Text(data.name)
                    .font(.headline(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text(data.detailAddress)
                    .font(.caption2(.regular))
                    .foreground(LegacyColor.Label.alternative)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
