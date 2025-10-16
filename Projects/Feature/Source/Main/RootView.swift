import SwiftUI
import Component
import Data

public struct RootView: View {
    @AppStorage("accessToken") var accessToken: String?
    @State private var selection: LegacyTabItem = .flag
    @State private var isTabBarHidden = false
    
    public init() {}
    
    public var body: some View {
        StoryUploadView()
        //        if accessToken != nil {
        //            LegacyTabBar(
        //                selection: $selection,
        //                isTabBarHidden: $isTabBarHidden
        //            ) {
        //                switch selection {
        //                case .shop:
        //                    ShopView(tabItem: $selection)
        //                case .medal:
        //                    AchievementView(tabItem: $selection)
        //                case .flag:
        //                    ExploreView($isTabBarHidden)
        //                case .course:
        //                    CourseView(tabItem: $selection)
        //                case .trophy:
        //                    RankingView(tabItem: $selection)
        //                }
        //            }
        //            .onAppear {
        //                print("현재 엑세스 토큰입니다.\(accessToken)")
        //                print("푸쉬 토큰임\(UserDefaults.standard.string(forKey: "FCMToken"))" ?? "FCMToken이 없습니다.")
        //            }
        //        } else {
        //            LoginView()
        //        }
    }
}

#Preview {
    RootView()
}
