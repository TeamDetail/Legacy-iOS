//
//  TitleBox.swift
//  Component
//
//  Created by 김은찬 on 10/20/25.
//

import SwiftUI
import Domain

public struct TitleBox: View {
    let data: UserTitleResponse
    let isSelected: Bool
    let onTap: () -> Void
    let action: () -> Void
    
    public init(
        data: UserTitleResponse,
        isSelected: Bool,
        onTap: @escaping () -> Void,
        action: @escaping () -> Void
    ) {
        self.data = data
        self.isSelected = isSelected
        self.onTap = onTap
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .foreground(LegacyColor.Fill.normal)
                
                TitleBadge(
                    title: data.name,
                    styleId: data.styleId
                )
                .padding(.horizontal, 8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(data.name)
                    .font(.body2(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text(data.content)
                    .font(.caption1(.medium))
                    .foreground(LegacyColor.Label.netural)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.bottom, 4)
            
            AnimationButton {
                action()
            } label: {
                Text("장착")
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
                    .font(.caption1(.bold))
                    .foreground(LegacyColor.Purple.normal)
                    .background(LegacyColor.Fill.normal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 5)
                            .stroke(lineWidth: 1)
                            .foreground(LegacyColor.Purple.normal)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(isSelected ? 1 : 0)
                    .offset(y: isSelected ? 0 : 10)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foreground(isSelected ? LegacyColor.Background.normal : LegacyColor.Common.black)
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isSelected)
        .onTapGesture {
            onTap()
        }
    }
}
