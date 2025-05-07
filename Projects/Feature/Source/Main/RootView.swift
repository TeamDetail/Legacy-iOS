//
//  RootView.swift
//  Feature
//
//  Created by dgsw30 on 5/5/25.
//

import SwiftUI
import Legacy_DesignSystem

public struct RootView: View {
    @State private var selection: LegacyTabItem = .flag
    public init() {}
    public var body: some View {
        LegacyTabBar(selection: $selection) {
            switch selection {
            case .shop:
                Test()
            case .medal:
                Test()
            case .flag:
                ExploreView()
            case .battle:
                Test()
            case .trophy:
                Test()
            }
        }
    }
}

#Preview {
    RootView()
}
