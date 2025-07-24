//
//  RegionItemGroup.swift
//  Feature
//
//  Created by 김은찬 on 7/24/25.
//

import SwiftUI
import Component

struct RegionItemGroup: View {
    @ObservedObject var data: CardViewModel
    @Binding var selectedRegion: RegionEnum
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(RegionEnum.allCases, id: \.self) { region in
                let cards = data.regionCardMap[region] ?? []
                RegionItem(
                    regionType: region,
                    cardLength: cards.count,
                    select: selectedRegion == region,
                    action: {
                        selectedRegion = region
                    }
                )
            }
        }
    }
}
