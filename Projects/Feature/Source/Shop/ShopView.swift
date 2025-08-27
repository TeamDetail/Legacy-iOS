//
//  ShopView.swift
//  Feature
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI
import Component
import Data

struct ShopView: View {
    @State private var selection = 0
    @Binding var tabItem: LegacyTabItem
    @StateObject private var viewModel = ShopViewModel()
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "상점", icon: .shop, item: tabItem) {
                VStack(spacing: 16) {
                    HStack {
                        CategoryButtonGroup(
                            categories: ["카드 팩", "크래딧 충전"],
                            selection: $selection
                        )
                        
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    
                    if selection == 0 {
                        AdvertiseView(viewModel: viewModel)
                        
                        if !viewModel.groupedCardPacks.isEmpty {
                            ForEach(viewModel.groupedCardPacks, id: \.0) { storeType, cardPacks in
                                VStack(spacing: 12) {
                                    HStack {
                                        Text(storeType.typeName)
                                            .font(.heading2(.bold))
                                            .foreground(LegacyColor.Common.white)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 14)
                                    
                                    ForEach(cardPacks, id: \.cardpackId) { cardPack in
                                        ShopItem(data: cardPack) {
                                            print("구매 선택: \(cardPack.cardpackName)")
                                        }
                                    }
                                }
                                .padding(.bottom, 20)
                            }
                        } else {
                            ForEach(1...6, id: \.self) { _ in
                                ErrorShopItem()
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            LegacyLoadingView(
                                description: ""
                            )
                        }
                    }
                }
            }
        }
        .onAppear {
            //MARK: 상점 브금 로그인 브금으로 대체
            SoundPlayer.shared.loginSound()
            Task {
                await viewModel.fetchShop()
            }
        }
        .refreshable {
            Task {
                viewModel.storeData = nil
                await viewModel.fetchShop()
            }
        }
    }
}
