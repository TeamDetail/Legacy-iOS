//
//  ShopView.swift
//  Feature
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI
import Component
import Data
import Domain

struct ShopView: View {
    @State private var selectedCardPack: CardPack? = nil
    @State private var showModal: Bool = false
    @State private var selection = 0
    @Binding var tabItem: LegacyTabItem
    @StateObject private var viewModel = ShopViewModel()
    
    var body: some View {
        ZStack {
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
                                                selectedCardPack = cardPack
                                                showModal = true
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
            .blur(radius: showModal ? 2 : 0)
            .animation(.easeInOut(duration: 0.25), value: showModal)
            
            if showModal {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) {
                            showModal = false
                        }
                    }
                    .transition(.opacity.animation(.easeInOut(duration: 0.2)))
                
                if showModal, let selected = selectedCardPack {
                    ConfirmModal(
                        confirm: {
                            Task {
                                await viewModel.buyCard(selected.cardpackId)
                            }
                            showModal = false
                        },
                        cancel: {
                            showModal = false
                        },
                        price: selected.price
                    )
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.7).combined(with: .opacity.animation(.easeOut(duration: 0.1))),
                        removal: .scale(scale: 0.9).combined(with: .opacity.animation(.easeIn(duration: 0.15)))
                    ))
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
