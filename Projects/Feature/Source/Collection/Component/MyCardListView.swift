//
//  MyCardListView.swift
//  Feature
//
//  Created by 김은찬 on 7/24/25.
//

import SwiftUI
import Domain
import Component

struct MyCardListView: View {
    @Binding var selectedRegion: RegionEnum
    let cardResponse: CardResponse
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CollectionProgressBar(
                cardLength: cardResponse.cards.count,
                maxCount: cardResponse.maxCount
            )
            .padding(.horizontal, 6)
            .padding(.top, 12)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(cardResponse.cards, id: \.cardId) { card in
                    RuinCardView(data: card)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 16)
            
            Spacer()
        }
    }
}

