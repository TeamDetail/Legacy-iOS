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
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6)
    ]
    let cards: [Card]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(cards, id: \.cardId) { card in
                    MyCardView(data: card)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Spacer()
        }
    }
}
