//
//  FriendsAddView.swift
//  Feature
//
//  Created by 김은찬 on 10/2/25.
//

import SwiftUI
import Component

struct FriendsAddView: View {
    @ObservedObject var viewModel: FriendsViewModel
    @State private var searchText = ""
    @State private var friendsCode = ""
    var body: some View {
        ScrollView(showsIndicators: false) {
            if let data = viewModel.myCode {
                VStack(spacing: 26) {
                    VStack(spacing: 14) {
                        FriendsOptionView(.myCode)
                        MyCodeField(myCode: data)
                    }
                    
                    VStack(spacing: 14) {
                        FriendsOptionView(.addFriendsCode)
                        FriendCodeField($friendsCode) {
                            Task {
                                await viewModel.requestFriend(friendsCode)
                            }
                        }
                    }
                    
                    LegacyDivider()
                    
                    VStack(spacing: 14) {
                        FriendsOptionView(.searchName)
                        
                        SearchField(
                            "친구 이름으로 검색..",
                            searchText: $searchText
                        ) {
                            Task {
                                await viewModel.searchFriends(searchText)
                            }
                        }
                        .padding(.horizontal, 6)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            if viewModel.isLoading {
                                LegacyLoadingView("")
                            } else if let data = viewModel.searchResult {
                                if data.isEmpty {
                                    Text("검색 결과가 없어요")
                                        .font(.headline(.bold))
                                        .foreground(LegacyColor.Common.white)
                                        .padding(.top, 40)
                                } else {
                                    ForEach(data, id: \.self) { friend in
                                        AddFriendsItem(data: friend) {
                                            Task {
                                                await viewModel.requestFriend(friend.friendCode)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            } else {
                LegacyLoadingView("")
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchAllData()
            }
        }
    }
}
