//
//  MyCodeField.swift
//  Component
//
//  Created by 김은찬 on 10/4/25.
//

import SwiftUI

public struct MyCodeField: View {
    public let myCode: String
    
    public init(myCode: String) {
        self.myCode = myCode
    }
    
    public var body: some View {
        HStack {
            Text(myCode)
                .font(.heading1(.bold))
                .foreground(LegacyColor.Common.white)
            
            Spacer()
            
            AnimationButton {
                UIPasteboard.general.string = myCode
            } label: {
                Text("복사")
                    .font(.body1(.medium))
                    .foreground(LegacyColor.Common.white)
                    .frame(width: 52, height: 35)
                    .background(LegacyColor.Primary.normal)
                    .clipShape(size: 8)
            }
        }
        .padding(.horizontal, 14)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(LegacyColor.Background.normal)
        .clipShape(size: 16)
        .padding(.horizontal, 10)
    }
}
