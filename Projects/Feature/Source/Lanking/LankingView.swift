import SwiftUI
import Component
import Shared

struct LankingView: View {
    @Binding var tabItem: LegacyTabItem
    @State private var selection = 0
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "랭킹", icon: .trophy, item: tabItem) {
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
                        RankingBoardView()
                    } else {
                        LegacyLoadingView(
                            description: ""
                        )
                    }
                }
            }
        }
    }
}
