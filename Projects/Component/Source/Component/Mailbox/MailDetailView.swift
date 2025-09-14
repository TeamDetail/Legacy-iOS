//
//  MailDetailView.swift
//  Component
//
//  Created by 김은찬 on 9/14/25.
//

import SwiftUI
import Domain

public struct MailDetailView: View {
    let data: MailResponse
    let close: () -> Void
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)
    
    public init(data: MailResponse, close: @escaping () -> Void) {
        self.data = data
        self.close = close
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AnimationButton {
                close()
            } label: {
                if #available(iOS 16.0, *) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.bold)
                        .foreground(LegacyColor.Common.white)
                } else {}
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(data.mailTitle)
                .font(.heading1(.bold))
                .foreground(LegacyColor.Common.white)
            
            Text(data.mailContent)
                .font(.body1(.medium))
                .foreground(LegacyColor.Label.netural)
            
            Spacer()
            
            Text("구성품")
                .font(.body1(.medium))
                .foreground(LegacyColor.Label.normal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(data.itemData, id: \.self) { item in
                    MailboxView()
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 18)
    }
}

