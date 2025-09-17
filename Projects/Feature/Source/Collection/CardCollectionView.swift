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
            HStack(alignment: .top) {
                //MARK: TODO: refactor
                RegionItemGroup(data: viewModel, selectedRegion: $selectedRegion)
                    .padding(.vertical, 12)
                
                VStack {
                    if viewModel.regionCardMap.isEmpty {
                        LegacyLoadingView("")
                    } else if let cards = viewModel.regionCardMap[selectedRegion] {
                        if cards.isEmpty {
                            Text("\(selectedRegion.regionName) 지역의 카드가 없어요!")
                                .font(.title2(.bold))
                                .foreground(LegacyColor.Common.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        } else {
                            MyCardListView(cards: cards)
                        }
                    } else {
                        LegacyLoadingView("")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
