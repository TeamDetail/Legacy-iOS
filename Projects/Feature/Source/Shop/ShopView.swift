//
//  ShopView.swift
//  Feature
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI
import Component

struct ShopView: View {
    @State private var selection = 0
    @Binding var tabItem: LegacyTabItem
    @StateObject private var viewModel = ShopViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
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
                        AdvertiseView(
                            viewModel: viewModel
                        )
                        
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(1...10, id: \.self) { _ in
                                PackButton(title: "삼국시대팩",
                                           description: "고구려 & 신라 & 백제 특성 카드가 포함된 카드팩",
                                           credit: "300,000",
                                           strokeColor: LegacyColor.Blue.alternative
                                ) {
                                    
                                }
                            }
                        }
                        .padding(.horizontal, 14)
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
            SoundPlayer.shared.marketSound()
        }
    }
}
