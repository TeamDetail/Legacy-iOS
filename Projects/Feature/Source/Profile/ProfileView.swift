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
    @State private var selection = 0
    @State private var showModal: Bool = false
    @State private var showPhotoPicker: Bool = false
    let data: UserInfoResponse?
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                if let data = data {
                    ProfileComponent(data) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            showModal = true
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
                    InventoryView()
                }
            }
            .padding(.horizontal, 10)
            .blur(radius: showModal ? 2 : 0)
            .animation(.easeInOut(duration: 0.25), value: showModal)
            
            if showModal {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) {
                            showModal = false
                        }
                    }
                    .transition(.opacity.animation(.easeInOut(duration: 0.2)))
                
                ChangeImageModal(
                    changeImage: {
                        showPhotoPicker = true
                        showModal = false
                    },
                    resetImage: {
                        print("초기화는 나중에~")
                    }
                )
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.7).combined(with: .opacity.animation(.easeOut(duration: 0.1))),
                    removal: .scale(scale: 0.9).combined(with: .opacity.animation(.easeIn(duration: 0.15)))
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
