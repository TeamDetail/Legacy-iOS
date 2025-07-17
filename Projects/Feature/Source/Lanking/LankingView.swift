import SwiftUI
import Component
import Shared

struct LankingView: View {
    @Binding var tabItem: LegacyTabItem
    @State private var selection = 0
    let lankingData: [(Int, String)] = [
        (4, "김건오"),
        (5, "김시원"),
        (6, "강건"),
        (7, "안현우"),
        (8, "나르샤 선생님")
    ]
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "랭킹", icon: .trophy, item: tabItem) {
                VStack(spacing: 16) {
                    HStack {
                        CategoryButtonGroup(
                            categories: ["친구", "전체"],
                            selection: $selection
                        )
                        
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    
                    if selection == 0 {
                        VStack {
                            HStack(spacing: 0) {
                                RankingBoardView(
                                    lank: "2위",
                                    name: "박재민",
                                    title: "짱짱맨",
                                    strokeColor: LegacyColor.Red.netural
                                )
                                
                                RankingBoardView(
                                    lank: "1위",
                                    name: "김은찬",
                                    title: "나르샤 팀장",
                                    strokeColor: LegacyColor.Purple.netural
                                )
                                .padding(.bottom, 40)
                                
                                RankingBoardView(
                                    lank: "3위",
                                    name: "김성한",
                                    title: "정박수",
                                    strokeColor: LegacyColor.Blue.netural
                                )
                            }
                            .padding(.horizontal, 12)
                        }
                        VStack(spacing: 12) {
                            ForEach(lankingData, id: \.0) { lank, name in
                                RankingAdventure(rank: lank, name: name)
                                    .padding(.horizontal, 8)
                            }
                            .padding(.vertical, 4)
                        }
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
