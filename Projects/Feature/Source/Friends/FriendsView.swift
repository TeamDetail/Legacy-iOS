//
//  FriendsView.swift
//  Feature
//
//  Created by 김은찬 on 10/2/25.
//

import Domain
import SwiftUI
import FlowKit
import Component

struct FriendsView: View {
    @StateObject private var viewModel = FriendsViewModel()
    @Flow var flow
    @State private var selection = 0
    var body: some View {
        VStack {
            HStack {
                CategoryButtonGroup(
                    categories: ["목록", "대기 중", "추가"],
                    selection: $selection
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if selection == 0 {
                FriendListView(
                    viewModel: viewModel,
                    selection: $selection
                )
            }
            
            if selection == 1 {
                FriendsPendingView(viewModel: viewModel)
            }
            
            if selection == 2 {
                FriendsAddView(viewModel: viewModel)
            }
            
            Spacer()
        }
        .statusModal(
            message: viewModel.successMessage,
            statusType: .success
        ) {
            viewModel.successMessage = ""
        }
        .statusModal(
            message: viewModel.errorMessage,
            statusType: .failure
        ) {
            viewModel.errorMessage = ""
        }
        .task {
            await viewModel.fetchAllData()
        }
        .padding(.horizontal, 8)
        .backButton(title: "친구") {
            flow.pop()
        }
    }
}

#Preview {
    FriendsView()
}
