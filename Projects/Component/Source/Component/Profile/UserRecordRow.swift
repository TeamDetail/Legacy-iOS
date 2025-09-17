//
//  UserRecordRow.swift
//  Component
//
//  Created by 김은찬 on 9/17/25.
//

import SwiftUI
import Domain

// MARK: - Row
struct UserRecordRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body1(.bold))
                .foreground(LegacyColor.Label.alternative)
            
            LegacyDivider()
                .padding(.horizontal, 4)
            
            Text(value)
                .font(.body1(.bold))
                .foreground(LegacyColor.Common.white)
        }
        .padding(.vertical, 4)
    }
}
