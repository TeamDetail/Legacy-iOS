//
//  MailboxView.swift
//  Component
//
//  Created by 김은찬 on 8/26/25.
//

import SwiftUI

public struct MailboxView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 5)
                .stroke(lineWidth: 1)
                .foreground(LegacyColor.Line.alternative)
                .overlay {
                    Image(icon: .coin)
                }
        }
        .frame(width: 40, height: 40)
        .background(LegacyColor.Fill.normal)
        .clipShape(size: 8)
    }
}

#Preview {
    MailboxView()
}
