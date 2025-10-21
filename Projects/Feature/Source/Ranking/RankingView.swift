import SwiftUI
import Component
import Shared
import Domain

struct RankingView: View {
    @StateObject private var viewModel = RankingViewModel()
    @Binding var tabItem: LegacyTabItem
    @State private var selection = 0
    @State private var rankType: RankType = .all
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "랭킹", icon: .trophy, item: tabItem) {
                VStack(spacing: 16) {
                    HStack {
                        CategoryButtonGroup(
                            categories: ["탐험", "숙련"],
                            selection: $selection
                        )
                        
                        Spacer()
                        RankingTypeButtonGroup(rankType: $rankType)
                    }
                    .padding(.horizontal, 14)
                    
                    if selection == 0 {
                        ExploreRankingContentView(
                            rankingList: viewModel.exploreRanking,
                            rankType: rankType
                        )
                    } else {
                        LevelRankingContentView(
                            rankingList: viewModel.levelRanking,
                            rankType: rankType
                        )
                    }
                }
            }
            .task {
                await viewModel.fetchRanking(isExplore: selection == 0, type: rankType)
            }
            .refreshable {
                await viewModel.fetchRanking(isExplore: selection == 0, type: rankType)
            }
            .onChange(of: selection) { newValue in
                Task { await viewModel.fetchRanking(isExplore: newValue == 0, type: rankType) }
            }
            .onChange(of: rankType) { newValue in
                Task { await viewModel.fetchRanking(isExplore: selection == 0, type: newValue) }
            }
        }
    }
}
