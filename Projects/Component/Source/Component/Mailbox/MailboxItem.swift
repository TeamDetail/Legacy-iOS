//
//  MailboxItem.swift
//  Component
//
//  Created by 김은찬 on 9/14/25.
//

import SwiftUI
import Domain

public struct MailboxItem: View {
    let data: MailResponse
    let action: () -> Void
    
    public init(data: MailResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Text(data.mailTitle)
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text(data.mailContent)
                    .font(.caption2(.regular))
                    .foreground(LegacyColor.Label.alternative)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
