//
//  LegacyDivider.swift
//  Component
//
//  Created by 김은찬 on 7/29/25.
//

import SwiftUI

public struct LegacyDivider: View {
    
    public init(){}
    
    public var body: some View {
        Rectangle()
            .foreground(LegacyColor.Line.alternative)
            .frame(maxWidth: .infinity)
            .frame(height: 0.8)
    }
}

#Preview {
    LegacyDivider()
}
