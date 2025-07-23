import SwiftUI
import Component
import Data

public struct RootView: View {
    @AppStorage("accessToken") var accessToken: String?
    @State private var selection: LegacyTabItem = .flag
    @State private var isTabBarHidden = false
    
    public init() {}
    
    public var body: some View {
        if accessToken != nil {
            LegacyTabBar(
                selection: $selection,
                isTabBarHidden: $isTabBarHidden
            ) {
                switch selection {
                case .shop:
                    ShopView(tabItem: $selection)
                case .medal:
                    LegacyEmptyView()
                case .flag:
                    ExploreView($isTabBarHidden)
                case .battle:
                    LegacyEmptyView()
                case .trophy:
                    RankingView(tabItem: $selection)
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
