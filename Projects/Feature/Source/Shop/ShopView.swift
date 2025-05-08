//
//  ShopView.swift
//  Feature
//
//  Created by dgsw30 on 5/8/25.
//

import SwiftUI
import Legacy_DesignSystem

struct ShopView: View {
    @State private var selection = 0
    var body: some View {
        LegacyScrollView(title: "상점", icon: .shop) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    CategoryButton(category: "카드 팩", select: selection == 0) {
                        selection = 0
                    }
                    CategoryButton(category: "크래딧 충전", select: selection == 1) {
                        selection = 1
                    }
                }
                .padding(.horizontal, 14)
            }
            .padding(.vertical, 8)
            AdvertiseView()
        }
    }
}

#Preview {
    ShopView()
}
