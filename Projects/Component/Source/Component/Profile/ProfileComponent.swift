//
//  Profile.swift
//  Component
//
//  Created by 김은찬 on 5/25/25.
//

import SwiftUI
import Kingfisher

public struct ProfileComponent: View {
    let action: () -> Void
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    public var body: some View {
        HStack {
            Circle()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("박재민입니다")
                        .font(.title3(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.spring(duration: 0.2)) {
                            HapticManager.instance.impact(style: .soft)
                            action()
                        }
                    } label: {
                        Image(icon: .pen)
                            .frame(width: 32, height: 32)
                            .background(LegacyColor.Background.normal)
                            .clipShape(size: 8)
                            .padding(.trailing, 8)
                    }
                }
                
                Text("Lv.99")
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Label.alternative)
                    .padding(.horizontal, 2)
                
                Text("자본주의")
                    .font(.body2(.bold))
                    .foreground(LegacyColor.Yellow.normal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 2)
                            .foreground(LegacyColor.Yellow.normal)
                    }
                    .background(LegacyColor.Fill.normal)
                    .clipShape(size: 8)
                    .padding(.horizontal, 2)
                    .padding(.trailing, 4)
            }
        }
    }
}
