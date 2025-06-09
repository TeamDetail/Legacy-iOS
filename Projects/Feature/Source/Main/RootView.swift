//
//  RootView.swift
//  Feature
//
//  Created by dgsw30 on 5/5/25.
//

import SwiftUI
import Component

public struct RootView: View {
    @State private var selection: LegacyTabItem = .flag
    public init() {}
    public var body: some View {
        //        LegacyTabBar(selection: $selection) {
        //            switch selection {
        //            case .shop:
        //                ShopView(tabItem: $selection)
        //            case .medal:
        //                EmptyView()
        //            case .flag:
        //                ExploreView()
        //            case .battle:
        //                EmptyView()
        //            case .trophy:
        //                LankingView(tabItem: $selection)
        //            }
        //        }
        LoginView()
        //Teste
    }
}

#Preview {
    RootView()
}
