//
//  EventItem.swift
//  Component
//
//  Created by 김은찬 on 12/1/25.
//

import SwiftUI
import Domain

public struct EventItem: View {
    let data: EventResponse
    let action: () -> Void
    
    public init(_ data: EventResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(data.title)
                        .font(.heading2(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Text(data.shortDescription)
                        .font(.caption1(.regular))
                        .foreground(LegacyColor.Label.alternative)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text(data.startAt)
                        .font(.caption1(.regular))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text("~ \(data.endAt)")
                        .font(.caption1(.regular))
                        .foreground(LegacyColor.Label.alternative)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .padding(.horizontal, 18)
            .background(LegacyColor.Fill.normal)
            .clipShape(size: 12)
        }
    }
}
