//
//  CreateOptionView.swift
//  Component
//
//  Created by 김은찬 on 9/11/25.
//

import SwiftUI

public struct CreateOptionView: View {
    let descriptionText: String
    public init(_ descriptionText: String) {
        self.descriptionText = descriptionText
    }
    
    public var body: some View {
        HStack {
            Text(descriptionText)
                .font(.body1(.bold))
                .foreground(LegacyColor.Label.alternative)
            
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}
