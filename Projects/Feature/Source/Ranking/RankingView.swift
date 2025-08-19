import SwiftUI
import Component
import Shared

struct RankingView: View {
    @StateObject private var viewModel = RankingViewModel()
    @Binding var tabItem: LegacyTabItem
    @State private var selection = 0
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "랭킹", icon: .trophy, item: tabItem) {
                VStack(spacing: 16) {
                    HStack {
                        CategoryButtonGroup(
                            categories: ["전체", "친구"],
                            selection: $selection
                        )
                        
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    
                    if selection == 0 {
                        VStack {
                            HStack(spacing: 0) {
                                if let data = viewModel.rankingList {
                                    let top3 = Array(data.prefix(3))
                                    
                                    HStack(spacing: 16) {
                                        if top3.count > 1 {
                                            TopRankersView(rankType: .two, data: top3[1])
                                        }
                                        if top3.count > 0 {
                                            TopRankersView(rankType: .one, data: top3[0])
                                                .padding(.bottom, 40)
                                        }
                                        if top3.count > 2 {
                                            TopRankersView(rankType: .three, data: top3[2])
                                        }
                                    }
                                    
                                } else {
                                    HStack(spacing: 16) {
                                        LoadingTopLankingview()
                                        LoadingTopLankingview()
                                            .padding(.bottom, 40)
                                        LoadingTopLankingview()
                                    }
                                    .padding(.horizontal, 14)
                                }
                            }
                            .padding(.horizontal, 12)
                        }
                        VStack(spacing: 12) {
                            if let data = viewModel.rankingList {
                                let others = Array(data.dropFirst(3))
                                ForEach(Array(others.enumerated()), id: \.1) { (index, data) in
                                    let rank = index + 4
                                    RankingBoardView(rank: rank, data: data)
                                        .padding(.horizontal, 4)
                                }
                            } else {
                                ForEach(1...20, id: \.self) { _ in
                                    LoadingRankingBoardView()
                                }
                            }
                        }
                        .padding(.vertical, 16)
                        .background(LegacyColor.Background.netural)
                        .clipShape(size: 16)
                        .padding(.horizontal, 12)
                    } else {
                        LegacyLoadingView(
                            description: ""
                        )
                    }
                }
            }
            .refreshable {
                await viewModel.onRefresh()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRanking()
            }
        }
    }
}
