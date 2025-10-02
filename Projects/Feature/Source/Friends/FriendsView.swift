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
    @Flow var flow
    @State private var selection = 0
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                CategoryButtonGroup(
                    categories: ["목록", "대기 중", "추가"],
                    selection: $selection
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
            
            if selection == 0 {
                FriendListView()
            }
            
            if selection == 1 {
                FriendsPendingView()
            }
            
            if selection == 2 {
                FriendsAddView()
            }
        }
        .padding(.horizontal, 10)
        .backButton(title: "친구") {
            flow.pop()
        }
    }
}

#Preview {
    FriendsView()
}
