//
//  FriendListView.swift
//  Feature
//
//  Created by 김은찬 on 10/2/25.
//

import SwiftUI
import Component
import Domain

struct FriendListView: View {
    @State private var showModal: Bool = false
    @State private var selectFriend: FriendsResponse? = nil
    @ObservedObject var viewModel: FriendsViewModel
    @Binding var selection: Int
    
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                if let friends = viewModel.friendsList {
                    if friends.isEmpty {
                        Spacer()
                        VStack(spacing: 12) {
                            Text("친구가 없습니다!")
                                .font(.heading1(.bold))
                                .foreground(LegacyColor.Common.white)
                            
                            AnimationButton {
                                selection = 2
                            } label: {
                                Text("추가하러 가기")
                                    .frame(width: 170, height: 50)
                                    .font(.body1(.bold))
                                    .foreground(LegacyColor.Label.assistive)
                                    .background(LegacyColor.Fill.normal)
                                    .clipShape(size: 8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .inset(by: 5)
                                            .stroke(lineWidth: 1)
                                            .foreground(LegacyColor.Line.alternative)
                                    )
                            }
                        }
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            ForEach(friends, id: \.self) { data in
                                FriendsItem(data: data) {
                                    selectFriend = data
                                    showModal = true
                                }
                            }
                            .padding(.top, 8)
                        }
                        .refreshable {
                            Task {
                                await viewModel.fetchAllData()
                            }
                        }
                    }
                } else {
                    LegacyLoadingView()
                    Spacer()
                }
            }
            .blur(radius: showModal ? 1 : 0)
            .animation(.easeInOut(duration: 0.25), value: showModal)
            
            if showModal, let data = selectFriend {
                LegacyModal(
                    title: "정말 해당 친구와 헤어질까요?",
                    description: "\(data.nickname) 님과 친구를 삭제합니다.",
                    confirm: {
                        Task {
                            await viewModel.deleteFriend(data.userId)
                            showModal = false
                        }
                    },
                    cancel: {
                        showModal = false
                    })
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.7).combined(with: .opacity.animation(.easeOut(duration: 0.1))),
                    removal: .scale(scale: 0.9).combined(with: .opacity.animation(.easeIn(duration: 0.15)))
                ))
            }
        }
    }
}
