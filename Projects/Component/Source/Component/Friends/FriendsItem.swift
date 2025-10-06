//
//  FriendsItem.swift
//  Component
//
//  Created by 김은찬 on 10/2/25.
//

import SwiftUI
import Domain
import Kingfisher

public struct FriendsItem: View {
    let data: FriendsResponse
    let action: () -> Void
    
    public init(data: FriendsResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: data.profileImage))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .clipShape(size: 8)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(data.nickname)
                    .font(.headline(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text("Lv. \(data.level)")
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
        .padding(.horizontal, 6)
    }
}
