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
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let cards: [CardResponse]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            VStack(spacing: 12) {
                ForEach(cards, id: \.cardId) { card in
                    MyCardView(data: card)
                }
            }
        }
    }
}
