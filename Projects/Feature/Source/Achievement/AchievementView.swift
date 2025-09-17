//
//  AchievementView.swift
//  Feature
//
//  Created by 김은찬 on 7/25/25.
//

import SwiftUI
import Component
import Data
import FlowKit

struct AchievementView: View {
    @StateObject private var viewModel = AchievementViewModel()
    @State private var selection = 0
    @Binding var tabItem: LegacyTabItem
    @Flow var flow
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "도전과제", icon: .medal, item: tabItem) {
                HStack {
                    VStack(spacing: 12) {
                        
                        CategoryButtonGroup(
                            categories: ["전체", "탐험", "숙련", "히든"],
                            selection: $selection
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        AllRewardButton() {}
                        
                        if let data = viewModel.achievementList {
                            ForEach(data, id:\.self) { data in
                                AchievementItem(data: data) {
                                    flow.push(
                                        AcheivementDetailView(data: data)
                                    )
                                }
                            }
                        } else {
                            LegacyLoadingView("")
                        }
                    }
                }
                .padding(.horizontal, 14)
            }
            .refreshable {
                await viewModel.onRefresh()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchAchievement()
            }
        }
    }
}

