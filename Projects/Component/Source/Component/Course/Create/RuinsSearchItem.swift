//
//  RuinsSearchItem.swift
//  Component
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI
import Domain

public struct RuinsSearchItem: View {
    let data: RuinsDetailResponse
    let selectedRuins: [RuinsDetailResponse]
    let onSelect: (RuinsDetailResponse) -> Void
    
    public init(
        data: RuinsDetailResponse,
        selectedRuins: [RuinsDetailResponse],
        onSelect: @escaping (RuinsDetailResponse) -> Void
    ) {
        self.data = data
        self.selectedRuins = selectedRuins
        self.onSelect = onSelect
    }
    
    public var body: some View {
        let displayIndex = selectedRuins.firstIndex(where: { $0.ruinsId == data.ruinsId }) ?? -1
        
        AnimationButton {
            onSelect(data)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 14) {
                    if displayIndex != -1 {
                        Text("\(displayIndex + 1)")
                            .font(.body2(.bold))
                            .foreground(LegacyColor.Common.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 20)
                            .background(LegacyColor.Blue.netural)
                            .clipShape(size: 12)
                    }
                    
                    Text("#\(data.ruinsId)")
                        .font(.caption1(.medium))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text(data.name)
                        .font(.heading1(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    DetailRatingInfoItem(data)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                
                if let card = data.card {
                    RuinCardView(data: card)
                        .frame(width: 120, height: 168)
                } else {
                    ErrorRuinsCardView()
                        .frame(width: 120, height: 168)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .padding(8)
        }
    }
}
