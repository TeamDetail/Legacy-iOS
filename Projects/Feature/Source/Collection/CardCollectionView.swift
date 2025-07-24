//
//  CardCollectionView.swift
//  Feature
//
//  Created by 김은찬 on 7/24/25.
//

import SwiftUI
import Component
import Domain

struct CardCollectionView: View {
    @StateObject private var viewModel = CardViewModel()
    @State private var selectedRegion: RegionEnum = .Gyeonggi
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                //MARK: TODO: refactor
                RegionItemGroup(data: viewModel, selectedRegion: $selectedRegion)
                    .padding(.vertical, 12)
                Spacer()
                if let cards = viewModel.regionCardMap[selectedRegion] {
                    MyCardListView(cards: cards)
                } else {
                    Text("\(selectedRegion.regionName) 지역의 카드가 없어요!")
                        .font(.title2(.bold))
                        .foreground(LegacyColor.Common.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchAllCards()
            }
        }
    }
}

#Preview {
    CardCollectionView()
}
