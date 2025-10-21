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
    
    private var dataForSelection: [AchievementResponse]? {
        selection == 0
        ? viewModel.achievementList
        : viewModel.achievementTypeList
    }
    
    private var categoryType: AchievementCategoryType? {
        switch selection {
        case 1: return .explore
        case 2: return .level
        case 3: return .hidden
        default: return nil
        }
    }
    
    var body: some View {
        LegacyView {
            LegacyScrollView(title: "도전과제", icon: .medal, item: tabItem) {
                VStack(spacing: 12) {
                    CategoryButtonGroup(
                        categories: ["전체", "탐험", "숙련", "히든"],
                        selection: $selection
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onChange(of: selection) { newValue in
                        Task {
                            viewModel.clearData()
                            if let type = categoryType {
                                await viewModel.fetchAchievementType(type)
                            } else {
                                await viewModel.fetchAchievement()
                            }
                        }
                    }
                    
                    AllRewardButton {
                        Task { await viewModel.fetchAward() }
                    }
                    
                    if let data = dataForSelection {
                        ForEach(data, id: \.self) { item in
                            AchievementItem(data: item) {
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
                await viewModel.onRefresh(selection: selection)
            }
        }
        .task {
            await viewModel.fetchAchievement()
        }
    }
}
