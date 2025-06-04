import SwiftUI
import Component
import Shared

struct LankingView: View {
    @Binding var tabItem: LegacyTabItem
    @State private var selection: ShopEnum = .trial
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "랭킹", icon: .trophy, item: tabItem) {
                HStack {
                    CategoryButton(category: "시련", select: selection == .trial) {
                        selection = .trial
                    }
                    CategoryButton(category: "탐험", select: selection == .adventure) {
                        selection = .adventure
                    }
                    CategoryButton(category: "숙련", select: selection == .skill) {
                        selection = .skill
                    }
                    
                    Spacer()
                    
                    LankingCategoryButton(category: "친구", select: selection == .friend) {
                        selection = .friend
                    }
                    LankingCategoryButton(category: "전체", select: selection == .all) {
                        selection = .all
                    }
                }
                .padding(.horizontal, 14)
                
                switch selection {
                case .trial:
                    ScrollView {
                        //                        RankingTrialView()
                        RankingBoardView()
                            .padding(.bottom, 80)
                    }
                default:
                    EmptyView()
                }
            }
            .padding(.top, 8)
        }
    }
}
