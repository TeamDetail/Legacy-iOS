//
//  ShopView.swift
//  Feature
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI
import Component

struct ShopView: View {
    @StateObject private var viewModel = ShopViewModel()
    @State private var selection = 0
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        LegacyScrollView(title: "상점", icon: .shop) {
            HStack {
                CategoryButton(category: "카드 팩", select: selection == 0) {
                    selection = 0
                }
                CategoryButton(category: "크래딧 충전", select: selection == 1) {
                    selection = 1
                }
            }
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
            AdvertiseView(
                viewModel: viewModel
            )
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(1...10, id: \.self) { _ in
                    PackButton(title: "삼국시대팩", description: "고구려 & 신라 & 백제 특성 카드가 포함된 카드팩", credit: "300,000", strokeColor: LegacyColor.Blue.alternative) {}
                }
            }
            .padding(.horizontal, 14)
            
            Spacer()
                .frame(height: 110)
        }
        .padding(.top, 80)
        .background(LegacyColor.Background.alternative)
        .overlay(alignment: .top) {
            LegacyTopBar()
        }
    }
}

#Preview {
    ShopView()
}
