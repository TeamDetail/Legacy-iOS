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
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(size: 16)
                    .clipped()
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 100, height: 100)
                    .redacted(reason: .placeholder)
                    .shimmering()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(data.nickname)
                            .font(.title3(.bold))
                            .foreground(LegacyColor.Common.white)
                        
                        Text("Lv.\(data.level)")
                            .font(.body1(.bold))
                            .foreground(LegacyColor.Label.alternative)
                            .padding(.horizontal, 2)
                    }
                    
                    Spacer()
                    
                    AnimationButton {
                        action()
                    } label: {
                        Image(icon: .pen)
                            .frame(width: 32, height: 32)
                            .padding(2)
                            .background(LegacyColor.Background.normal)
                            .clipShape(size: 99)
                    }
                }
                
                TitleBadge(
                    title: data.title.name,
                    styleId: data.title.styleId
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)
            }
        }
    }
}
