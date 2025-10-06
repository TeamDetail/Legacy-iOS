//
//  FriendsListDropDown.swift
//  Component
//
//  Created by 김은찬 on 10/6/25.
//

import SwiftUI

public struct FriendsListDropDown: View {
    @Binding var isExpanded: Bool
    let description: String
    let length: Int
    
    public init(isExpanded: Binding<Bool>, description: String, length: Int) {
        self._isExpanded = isExpanded
        self.description = description
        self.length = length
    }
    
    public var body: some View {
        HStack {
            Text(description)
                .font(.body1(.regular))
                .foreground(LegacyColor.Label.alternative)
            
            Text("\(length)")
                .font(.body1(.bold))
                .foreground(LegacyColor.Common.white)
            
            Spacer()
            
            AnimationButton {
                isExpanded.toggle()
            } label: {
                Circle()
                    .foreground(LegacyColor.Fill.normal)
                    .frame(width: 28, height: 28)
                    .overlay {
                        Image(systemName: "chevron.down")
                            .foreground(LegacyColor.Common.white)
                            .font(.body2(.bold))
                    }
            }
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 8)
        .padding(.horizontal, 4)
    }
}
