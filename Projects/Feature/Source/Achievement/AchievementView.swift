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
    @State private var showRewardModal = false
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
                        Task {
                            await viewModel.fetchAward()
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                showRewardModal = true
                            }
                        }
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
            .overlay {
                if showRewardModal {
                    RewardModalView(
                        award: viewModel.achievementAward,
                        isPresented: $showRewardModal
                    )
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .scale(scale: 0.8)),
                        removal: .opacity.combined(with: .scale(scale: 0.9))
                    ))
                }
            }
        }
        .task {
            await viewModel.fetchAchievementType(categoryType)
        }
    }
}

// MARK: - Reward Modal View
struct RewardModalView: View {
    let award: AchievementAwardResponse?
    @Binding var isPresented: Bool
    @State private var backgroundOpacity: Double = 0
    @State private var contentScale: CGFloat = 0.8
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(backgroundOpacity * 0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissModal()
                }
            
            VStack(spacing: 20) {
                if let award = award, award.itemId != nil {
                    RewardSuccessView(award: award, isPresented: $isPresented, dismissAction: dismissModal)
                } else {
                    RewardEmptyView(isPresented: $isPresented, dismissAction: dismissModal)
                }
            }
            .padding(24)
            .background(LegacyColor.Background.normal)
            .clipShape(size: 16)
            .padding(.horizontal, 40)
            .scaleEffect(contentScale)
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                backgroundOpacity = 1.0
                contentScale = 1.0
            }
        }
    }
    
    private func dismissModal() {
        withAnimation(.easeOut(duration: 0.25)) {
            backgroundOpacity = 0
            contentScale = 0.9
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            isPresented = false
        }
    }
}

// MARK: - Empty Reward View (첫 번째 이미지)
struct RewardEmptyView: View {
    @Binding var isPresented: Bool
    let dismissAction: () -> Void
    @State private var emojiScale: CGFloat = 0.5
    @State private var textOpacity: Double = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Image(icon: .crying)
                .scaleEffect(emojiScale)
                .onAppear {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.1)) {
                        emojiScale = 1.0
                    }
                }
            
            Text("수령할 보상이 없어요...")
                .font(.heading1(.bold))
                .foreground(LegacyColor.Common.white)
                .opacity(textOpacity)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.3).delay(0.3)) {
                        textOpacity = 1.0
                    }
                }
        }
        .padding()
    }
}

// MARK: - Success Reward View (두 번째 이미지)
struct RewardSuccessView: View {
    let award: AchievementAwardResponse
    @Binding var isPresented: Bool
    let dismissAction: () -> Void
    @State private var titleScale: CGFloat = 0.8
    @State private var titleOpacity: Double = 0
    @State private var subtitleOpacity: Double = 0
    @State private var itemsAppeared = false
    
    var body: some View {
        VStack(spacing: 12) {
            Text("보상 수령 완료!")
                .font(.heading2(.bold))
                .foreground(LegacyColor.Yellow.netural)
                .scaleEffect(titleScale)
                .opacity(titleOpacity)
                .onAppear {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7).delay(0.1)) {
                        titleScale = 1.0
                        titleOpacity = 1.0
                    }
                }
            
            Text("도전과제 완료를 축하드려요~!")
                .font(.caption1(.medium))
                .foreground(LegacyColor.Label.alternative)
                .opacity(subtitleOpacity)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.3).delay(0.3)) {
                        subtitleOpacity = 1.0
                    }
                }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 5), spacing: 12) {
                ForEach(0..<(award.itemCount ?? 0), id: \.self) { index in
                    InventoryItem() {}
                        .opacity(itemsAppeared ? 1 : 0)
                        .scaleEffect(itemsAppeared ? 1 : 0.3)
                        .animation(
                            .spring(response: 0.4, dampingFraction: 0.7)
                            .delay(0.4 + Double(index) * 0.03),
                            value: itemsAppeared
                        )
                }
            }
            .padding(.vertical, 12)
            .onAppear {
                itemsAppeared = true
            }
            
            Button {
                dismissAction()
            } label: {
                Text("확인")
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Line.netural)
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Line.netural)
                    )
            }
            .opacity(itemsAppeared ? 1 : 0)
            .animation(.easeOut(duration: 0.3).delay(0.7), value: itemsAppeared)
        }
        .padding(8)
    }
}
