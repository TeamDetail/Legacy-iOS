//
//  Profile.swift
//  Feature
//
//  Created by dgsw27 on 5/14/25.
//

import Domain
import SwiftUI
import FlowKit
import Component

struct ProfileView: View {
    @Flow var flow
    let viewModel: UserInfoResponse?
    @State private var selection = 0
    @State private var showModal: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                if let data = viewModel {
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
                        categories: ["내 기록", "칭호", "도감"],
                        selection: $selection
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                
                if selection == 0 {
                    if let data = viewModel {
                        ActivityRecordView(data: data)
                            .padding(.top, 8)
                    } else {
                        LegacyLoadingView(
                            description: ""
                        )
                    }
                }
                
                if selection == 1 {
                    LegacyLoadingView(
                        description: ""
                    )
                }
                
                if selection == 2 {
                    CardCollectionView()
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
    }
}
