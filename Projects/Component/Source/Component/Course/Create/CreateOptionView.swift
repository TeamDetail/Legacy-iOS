//
//  CreateOptionView.swift
//  Component
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI

public enum CreateOptionType {
    case description
    case select
    
    var title: String {
        switch self {
        case .description:
            return "코스 설명"
        case .select:
            return "선택된 유적지"
        }
    }
}

public struct CreateOptionView: View {
    let descriptionText: CreateOptionType
    
    public init(_ descriptionText: CreateOptionType) {
        self.descriptionText = descriptionText
    }
    
    public var body: some View {
        HStack {
            Text(descriptionText.title)
                .font(.body1(.bold))
                .foreground(LegacyColor.Label.alternative)
            
            Spacer()
            
            if descriptionText == .select {
                Text("( 클릭 시 삭제 )")
                    .font(.label(.regular))
                    .foreground(LegacyColor.Label.alternative)
            }
        }
        .padding(.horizontal, 8)
    }
}
