//
//  FriendsPendingView.swift
//  Feature
//
//  Created by 김은찬 on 10/2/25.
//

import SwiftUI
import Component

struct FriendsPendingView: View {
    @State private var showSentList = false
    @State private var showRequestList = false
    @ObservedObject var viewModel: FriendsViewModel
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 14) {
                if let sentList = viewModel.sentFriendsList,
                   let requestList = viewModel.requestFriendsList {
                    VStack(spacing: 20) {
                        FriendsListDropDown(
                            isExpanded: $showSentList,
                            description: "보낸 친구 추가",
                            length: sentList.count
                        )
                        if showSentList {
                            ScrollView(showsIndicators: false) {
                                ForEach(sentList, id: \.self) { data in
                                    SentFriendsItem(data: data) {
                                        Task {
                                            await viewModel.cancelSentRequest(data.requestId)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: 20) {
                        FriendsListDropDown(
                            isExpanded: $showRequestList,
                            description: "받은 친구 추가",
                            length: requestList.count
                        )
                        if showRequestList {
                            ScrollView(showsIndicators: false) {
                                ForEach(requestList, id: \.self) { data in
                                    RequestFriendsItem(data: data) {
                                        Task {
                                            await viewModel.acceptFriend(data.requestId)
                                        }
                                    } onCancel: {
                                        Task {
                                            await viewModel.cancelSentRequest(data.requestId)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    LegacyLoadingView()
                }
            }
            .padding(.top, 14)
        }
        .refreshable {
            Task {
                await viewModel.fetchAllData()
            }
        }
    }
}
