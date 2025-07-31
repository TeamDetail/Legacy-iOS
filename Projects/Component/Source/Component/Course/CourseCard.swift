//
//  CourseCard.swift
//  Component
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI
import Shimmer
import Kingfisher

public struct CourseCard: View {
    let url: String
    
    public init(url: String) {
        self.url = url
    }
    
    public var body: some View {
        VStack {
            KFImage(URL(string: url))
                .placeholder { _ in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 144, height: 220)
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 144, height: 220)
                .clipShape(size: 12)
        }
        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 4) {
                EventTag()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("AlldayProject")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Label.normal)
                    
                    Text("영서")
                        .font(.caption2(.medium))
                        .foreground(LegacyColor.Label.assistive)
                }
                
                HStack(spacing: 8) {
                    StatItem(
                        statType: .heart,
                        text: "999+"
                    ) {
                        
                    }
                    
                    StatItem(
                        statType: .flag,
                        text: "108"
                    ) {
                        
                    }
                }
            }
            .padding(8)
        }
    }
}
