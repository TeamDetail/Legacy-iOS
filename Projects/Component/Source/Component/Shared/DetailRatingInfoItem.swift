//
//  DetailRatingInfoItem.swift
//  Component
//
//  Created by 김은찬 on 8/29/25.
//

import SwiftUI

public struct DetailRatingInfoItem: View {
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                ForEach(1...5, id: \.self) { _ in
                    HStack(spacing: 0) {
                        Image(icon: .leftStar)
                            .resizable()
                            .frame(width: 7, height: 13)
                        
                        Image(icon: .rightStar)
                            .resizable()
                            .frame(width: 7, height: 13)
                    }
                }
                .foreground(LegacyColor.Primary.normal)
                
                Text("( 302 )")
                    .font(.caption2(.medium))
                    .foreground(LegacyColor.Fill.alternative)
                
                Spacer()
            }
            
            LegacyDivider()
            
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("탐험자 수")
                        .font(.caption2(.regular))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text("200001명")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Label.normal)
                }
                
                VStack(alignment: .leading) {
                    Text("탐험자 수")
                        .font(.caption2(.regular))
                        .foreground(LegacyColor.Label.alternative)
                    
                    Text("14.5%")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Label.normal)
                }
                
                Spacer()
            }
        }
    }
}
