//
//  KaKaoButton.swift
//  Component
//
//  Created by 김은찬 on 9/30/25.
//

import SwiftUI

public struct KaKaoButton: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        AnimationButton {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color(0xFEE500))
                .frame(width: 300, height: 45)
                .overlay {
                    HStack {
                        Image(icon: .talk)
                        Spacer()
                        Text("카카오 로그인")
                            .font(.body2(.bold))
                            .foreground(LegacyColor.Common.black)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(width: 300)
                }
        }
    }
}
