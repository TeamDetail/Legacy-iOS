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
                            categories: ["친구", "전체"],
                            selection: $selection
                        )
                        
                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    
                    if selection == 0 {
                        VStack {
                            HStack(spacing: 0) {
                                //                                let top3 = Array(rankingList.prefix(3))
                                //                                RankingBoardView(
                                //                                    lank: "2위",
                                //                                    name: "박재민",
                                //                                    title: "짱짱맨",
                                //                                    strokeColor: LegacyColor.Red.netural
                                //                                )
                                //
                                //                                RankingBoardView(
                                //                                    lank: "1위",
                                //                                    name: "김은찬",
                                //                                    title: "나르샤 팀장",
                                //                                    strokeColor: LegacyColor.Purple.netural
                                //                                )
                                //                                .padding(.bottom, 40)
                                //
                                //                                RankingBoardView(
                                //                                    lank: "3위",
                                //                                    name: "김성한",
                                //                                    title: "정박수",
                                //                                    strokeColor: LegacyColor.Blue.netural
                                //                                )
                                LoadingTopLankingview()
                                LoadingTopLankingview()
                                    .padding(.bottom, 40)
                                LoadingTopLankingview()
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
                        .padding(.vertical, 14)
                        .background(LegacyColor.Background.netural)
                        .clipShape(size: 16)
                        .padding(.horizontal, 8)
                    } else {
                        LegacyLoadingView(
                            description: ""
                        )
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRanking()
            }
        }
    }
}
