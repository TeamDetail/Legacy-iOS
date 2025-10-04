//
//  RequestFriendsItem.swift
//  Component
//
//  Created by 김은찬 on 10/4/25.
//

import SwiftUI
import Domain
import Kingfisher

public struct RequestFriendsItem: View {
    let data: FriendsResponse
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    public init(data: FriendsResponse, onConfirm: @escaping () -> Void, onCancel: @escaping () -> Void) {
        self.data = data
        self.onConfirm = onConfirm
        self.onCancel = onCancel
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
            
            VStack(spacing: 8) {
                AnimationButton {
                    onConfirm()
                } label: {
                    Circle()
                        .frame(width: 36, height: 36)
                        .foreground(LegacyColor.Fill.netural)
                        .overlay {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .font(.headline(.bold))
                                .foreground(LegacyColor.Label.netural)
                        }
                }
                
                AnimationButton {
                    onCancel()
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
        }
        .padding(.horizontal, 8)
    }
}
