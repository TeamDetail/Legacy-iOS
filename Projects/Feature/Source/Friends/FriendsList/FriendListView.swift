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
    @ObservedObject var viewModel: FriendsViewModel
    @Binding var selection: Int
    
    var body: some View {
        VStack(spacing: 12) {
            if let friends = viewModel.friendsList {
                if friends.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Text("친구가 없습니다!")
                            .font(.heading1(.bold))
                            .foreground(LegacyColor.Common.white)
                        
                        AnimationButton {
                            selection = 1
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
                        ForEach(friends, id: \.self) { friend in
                            FriendsItem(data: friend) {
                                // TODO: 삭제 기능 구현
                            }
                        }
                    }
                    .refreshable {
                        Task {
                            await viewModel.fetchAllData()
                        }
                    }
                }
            } else {
                LegacyLoadingView("")
                Spacer()
            }
        }
    }
}
