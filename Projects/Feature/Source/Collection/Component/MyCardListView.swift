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
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    let cards: [Card]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(cards, id: \.cardId) { card in
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
