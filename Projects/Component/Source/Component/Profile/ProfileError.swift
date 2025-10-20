//
//  ProfileError.swift
//  Component
//
//  Created by 김은찬 on 6/24/25.
//


import Domain
import SwiftUI
import Kingfisher

public struct ProfileError: View {
    public init() {}
    
    public var body: some View {
        HStack {
            Circle()
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("unknown")
                        .font(.title3(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Spacer()
                    
                    
                    Image(icon: .pen)
                        .frame(width: 32, height: 32)
                        .background(LegacyColor.Background.normal)
                        .clipShape(size: 8)
                        .padding(.trailing, 8)
                }
                
                Text("Lv.0")
                    .font(.body1(.bold))
                    .foreground(LegacyColor.Label.alternative)
                    .padding(.horizontal, 2)
            }
        }
    }
}

