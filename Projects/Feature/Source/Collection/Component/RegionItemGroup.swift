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
                RegionItem(
                    regionType: region,
                    cardLength: data.regionCardMap[region]?.cards.count ?? 0,
                    select: selectedRegion == region,
                    maxCount: data.regionCardMap[region]?.maxCount ?? 0
                ) {
                    selectedRegion = region
                }
            }
        }
    }
}
