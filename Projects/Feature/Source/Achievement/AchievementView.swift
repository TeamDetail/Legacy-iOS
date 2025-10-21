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
import Domain

struct AchievementView: View {
    @StateObject private var viewModel = AchievementViewModel()
    @State private var selection = 0
    @Binding var tabItem: LegacyTabItem
    @Flow var flow
    
    private var categoryType: AchievementCategoryType {
        switch selection {
        case 0: return .explore
        case 1: return .level
        case 2: return .hidden
        default: return .explore
        }
    }
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "도전과제", icon: .medal, item: tabItem) {
                VStack(spacing: 12) {
                    CategoryButtonGroup(
                        categories: ["탐험", "숙련", "히든"],
                        selection: $selection
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onChange(of: selection) { _ in
                        Task {
                            viewModel.clearData()
                            await viewModel.fetchAchievementType(categoryType)
                        }
                    }
                    
                    AllRewardButton {
                        Task { await viewModel.fetchAward() }
                    }
                    
                    if let data = viewModel.achievementTypeList {
                        ForEach(data, id: \.self) { item in
                            AchievementItem(data: item, selection: selection) {
                                flow.push(AchievementDetailView(data: item))
                            }
                        }
                    } else {
                        LegacyLoadingView()
                    }
                }
                .padding(.horizontal, 14)
            }
            .refreshable {
                await viewModel.onRefresh(category: categoryType)
            }
        }
        .task {
            await viewModel.fetchAchievementType(categoryType)
        }
    }
}

