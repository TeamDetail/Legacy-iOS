//
//  RootView.swift
//  Feature
//
//  Created by dgsw30 on 5/5/25.
//

import SwiftUI
import Component
import Data

public struct RootView: View {
    @AppStorage("accessToken") var accessToken: String?
    @State private var selection: LegacyTabItem = .flag
    public init() {}
    public var body: some View {
        if accessToken != nil {
            LegacyTabBar(selection: $selection) {
                switch selection {
                case .shop:
                    ShopView(tabItem: $selection)
                case .medal:
                    LegacyEmptyView()
                case .flag:
                    ExploreView()
                    //MARK: showing google mark
//                        .padding(.bottom, 100)
//                        .background(LegacyColor.Background.normal)
                case .battle:
                    LegacyEmptyView()
                case .trophy:
                    LankingView(tabItem: $selection)
                }
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    RootView()
}
