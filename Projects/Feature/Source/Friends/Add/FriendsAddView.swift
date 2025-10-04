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
                        FriendCodeField($searchText) {
                            
                        }
                    }
                    
                    LegacyDivider()
                    
                    VStack(spacing: 14) {
                        FriendsOptionView(.searchName)
                        
                        SearchField(
                            "친구 이름으로 검색..",
                            searchText: $searchText
                        ) {
                            
                        }
                        .padding(.horizontal, 6)
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
