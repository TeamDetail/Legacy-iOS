//
//  SentFriendsItem.swift
//  Component
//
//  Created by 김은찬 on 10/6/25.
//

import SwiftUI
import Domain
import Kingfisher

public struct SentFriendsItem: View {
    let data: FriendRequestResponse
    let action: () -> Void
    
    public init(data: FriendRequestResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: data.receiverProfileImage ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .clipShape(size: 8)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(data.receiverNickname ?? "알수 없음")
                    .font(.headline(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text("Lv. \(data.receiverLevel)")
                    .font(.label(.medium))
                    .foreground(LegacyColor.Label.alternative)
            }
            
            Spacer()
            
            AnimationButton {
                action()
            } label: {
                Circle()
                    .frame(width: 36, height: 36)
                    .foreground(LegacyColor.Fill.netural)
                    .overlay {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .font(.headline(.bold))
                            .foreground(LegacyColor.Label.netural)
                    }
            }
        }
        .padding(.horizontal, 8)
    }
}

