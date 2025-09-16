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
    @StateObject var viewModel = UserViewModel()
    @StateObject private var inventoryViewModel = InventoryViewModel()
    @State private var selection = 0
    @State private var showPhotoPicker: Bool = false
    let data: UserInfoResponse?
    
    @State private var revealCard = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                if let data = data {
                    ProfileComponent(data) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            //MARK: 수정 뷰로 이동 처리
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
                        LegacyLoadingView(description: "")
                    }
                }
                
                if selection == 1 {
                    LegacyLoadingView(description: "")
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
                        inventoryViewModel.selectedItem = nil
                    }
                
                InventoryModal(selectedData) {
                    Task {
                        await inventoryViewModel.openInventory(
                            .init(cardpackId: selectedData.itemId, count: selectedData.itemCount)
                        )
                        inventoryViewModel.selectedItem = nil
                        revealCard = true
                    }
                }
            }
            
            if revealCard, let openedCards = inventoryViewModel.openedCards {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                    .onTapGesture {
                        revealCard = false
                    }
                
                VStack {
                    CardRevealModal(
                        packName: "카드팩",
                        cards: openedCards
                    ) {
                        revealCard = false
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .backButton(title: "프로필") {
            flow.pop()
        }
        .sheet(isPresented: $showPhotoPicker, onDismiss: {
            Task { await viewModel.editProfileImage() }
        }) {
            PhotoPicker(image: $viewModel.image)
        }
        .task {
            await viewModel.fetchMyinfo()
        }
    }
}
