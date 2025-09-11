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
    
    @State private var showInventory = false
    
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
                        showInventory: $showInventory
                    )
                }
            }
            .padding(.horizontal, 10)
            .blur(radius: showInventory ? 2 : 0)
            .animation(.easeInOut(duration: 0.25), value: showInventory)
            
            if showInventory, let data = inventoryViewModel.selectedItem {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) {
                            showInventory = false
                        }
                    }
                    .transition(.opacity.animation(.easeInOut(duration: 0.2)))
                
                InventoryModal(data) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        Task {
                            await inventoryViewModel.openInventory(
                                .init(cardpackId: data.itemId, count: data.itemCount)
                            )
                        }
                        showInventory = false
                    }
                }
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.7)
                        .combined(with: .opacity.animation(.easeOut(duration: 0.1))),
                    removal: .scale(scale: 0.9)
                        .combined(with: .opacity.animation(.easeIn(duration: 0.15)))
                ))
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
