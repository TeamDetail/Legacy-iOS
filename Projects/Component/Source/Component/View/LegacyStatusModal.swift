//
//  LegacyStatusModal.swift
//  Component
//
//  Created by 김은찬 on 9/13/25.
//

import SwiftUI

public struct LegacyStatusModal: View {
    let statusType: LegacyStatusType
    let description: String
    
    public init(statusType: LegacyStatusType, description: String) {
        self.statusType = statusType
        self.description = description
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            statusType.icon
            
            Text(description)
                .font(.body1(.bold))
                .foreground(statusType == .success ? LegacyColor.Status.positive : LegacyColor.Status.negative)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(LegacyColor.Fill.normal)
        .clipShape(size: 16)
    }
}
