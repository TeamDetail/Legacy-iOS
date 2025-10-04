//
//  FriendsOptionView.swift
//  Component
//
//  Created by 김은찬 on 10/4/25.
//

import SwiftUI

public enum FriendsOptionType {
    case myCode
    case addFriendsCode
    case searchName
    
    var title: String {
        switch self {
        case .myCode:
            return "내 친구 코드"
        case .addFriendsCode:
            return "친구 코드로 추가하기"
        case .searchName:
            return "이름으로 검색하기"
        }
    }
}

public struct FriendsOptionView: View {
    let descriptionText: FriendsOptionType
    
    public init(_ descriptionText: FriendsOptionType) {
        self.descriptionText = descriptionText
    }
    
    public var body: some View {
        HStack {
            Text(descriptionText.title)
                .font(.body1(.medium))
                .foreground(LegacyColor.Label.netural)
            
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}
