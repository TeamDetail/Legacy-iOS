//
//  RootView.swift
//  Feature
//
//  Created by dgsw30 on 5/5/25.
//

import SwiftUI
import Component

public struct RootView: View {
    @State private var selection: LegacyTabItem = .shop
    public init() {}
    public var body: some View {
        LegacyTabBar(selection: $selection) {
            switch selection {
            case .shop:
                ShopView()
            case .medal:
                EmptyView()
            case .flag:
                ExploreView()
            case .battle:
                EmptyView()
            case .trophy:
                LankingView()
            }
        }
        //        LoginView()
    }
}

#Preview {
    RootView()
}
