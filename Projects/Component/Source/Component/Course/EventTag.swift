//
//  EventTag.swift
//  Component
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI

public struct EventTag: View {
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("이벤트 중!")
                .font(.custom("Pretendard-Bold", size: 10))
                .foreground(LegacyColor.Common.white)
        }
        .frame(width: 57, height: 16)
        .background(LegacyColor.Red.netural)
        .cornerRadius(999)
    }
}

#Preview {
    EventTag()
}
