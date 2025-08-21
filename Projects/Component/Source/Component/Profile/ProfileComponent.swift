//
//  Profile.swift
//  Component
//
//  Created by 김은찬 on 5/25/25.
//

import Domain
import SwiftUI
import Shimmer
import Kingfisher

public struct ProfileComponent: View {
    let data: UserInfoResponse
    let action: () -> Void
    
    public init(_ data: UserInfoResponse, editAction: @escaping () -> Void) {
        self.data = data
        self.action = editAction
    }
    
    public var body: some View {
        HStack {
            if let url = URL(string: data.imageUrl) {
                KFImage(url)
                    .placeholder { _ in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 140, height: 180)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(size: 50)
            } else {
                Circle()
                    .frame(width: 100, height: 100)
                    .redacted(reason: .placeholder)
                    .shimmering()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(data.nickname)
                        .font(.title3(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Spacer()
                    
                    AnimationButton {
                        action()
                    } label: {
                        Image(icon: .pen)
                            .frame(width: 32, height: 32)
                            .background(LegacyColor.Background.normal)
                            .clipShape(size: 8)
                            .padding(.trailing, 8)
                    }
                }
                
                Text("Lv.\(data.level)")
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Label.alternative)
                    .padding(.horizontal, 2)
                
                if !data.title.name.isEmpty {
                    TitleBadge(data.title.name, color: LegacyColor.Yellow.netural, size: .big)
                }
            }
        }
    }
}
