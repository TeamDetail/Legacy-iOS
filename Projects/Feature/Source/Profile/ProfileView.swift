//
//  ProfileView.swift
//  Feature
//

import Domain
import SwiftUI
import FlowKit
import Component

struct ProfileView: View {
    @Flow var flow
    @EnvironmentObject var viewModel: UserViewModel
    @StateObject private var inventoryViewModel = InventoryViewModel()
    @State private var selection = 0
    let data: UserInfoResponse?
    
    @State private var showCountModal = false
    @State private var revealCard = false
    @State private var openCount = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                if let data = data {
                    ProfileComponent(data) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            flow.push(EditInfoView(viewModel: viewModel))
                        }
                    }
                } else {
                    ProfileError()
                }
                HStack {
                    CategoryButtonGroup(
                        categories: ["내 기록", "칭호", "도감", "인벤토리"],
                        selection: $selection
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                
                if selection == 0 {
                    if let data = data {
                        ActivityRecordView(data: data)
                            .padding(.top, 8)
                    } else {
                        LegacyLoadingView()
                    }
                }
                
                if selection == 1 {
                    UserTitleView()
                        .padding(.top, 8)
                }
                
                if selection == 2 {
                    CardCollectionView()
                }
                
                if selection == 3 {
                    InventoryView(
                        viewModel: inventoryViewModel,
                        revealCard: $revealCard
                    )
                }
            }
            .padding(.horizontal, 10)
            .blur(radius: revealCard || inventoryViewModel.selectedItem != nil ? 2 : 0)
            .animation(.easeInOut(duration: 0.25), value: revealCard)
            .animation(.easeInOut(duration: 0.25), value: inventoryViewModel.selectedItem != nil)
            
            if let selectedData = inventoryViewModel.selectedItem {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        if !showCountModal {
                            inventoryViewModel.selectedItem = nil
                        }
                    }
                
                InventoryModal(selectedData) {
                    showCountModal = true
                }
            }
            
            if let selectedData = inventoryViewModel.selectedItem {
                if showCountModal {
                    VStack {
                        CountModal(
                            count: $openCount,
                            maxCount: selectedData.itemCount
                        ) {
                            Task {
                                // MARK: 카드팩 or 크레딧팩
                                if selectedData.itemType == .cardPack {
                                    await inventoryViewModel.openInventory(
                                        .init(cardpackId: selectedData.itemId, count: openCount)
                                    )
                                    showCountModal = false
                                    revealCard = true
                                } else {
                                    await inventoryViewModel.openCredit(
                                        .init(creditpackId: selectedData.itemId, count: openCount)
                                    )
                                    showCountModal = false
                                    flow.pop()
                                }
                            }
                        } onCancel: {
                            showCountModal = false
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.scale.combined(with: .opacity))
                }
            }
            
            if revealCard, let openedCards = inventoryViewModel.openedCards, let packName = inventoryViewModel.selectedItem {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                
                VStack {
                    CardRevealModal(
                        packName: packName.itemName,
                        cards: openedCards
                    ) {
                        revealCard = false
                        inventoryViewModel.selectedItem = nil
                        selection = 2
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .statusModal(
            message: viewModel.successMessage,
            statusType: .success,
            bottomPadding: 30
        ) {
            viewModel.successMessage = ""
            flow.pop()
        }
        .statusModal(
            message: viewModel.errorMessage,
            statusType: .failure,
            bottomPadding: 30
        ) {
            viewModel.errorMessage = ""
        }
        .backButton(title: "프로필") {
            flow.pop()
        }
        .task {
            await viewModel.fetchMyinfo()
        }
    }
}
