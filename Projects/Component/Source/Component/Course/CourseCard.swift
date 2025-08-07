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
        ZStack(alignment: .bottomLeading) {
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
            
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.black.opacity(0.0), location: 0.5),
                    .init(color: Color.black.opacity(0.7), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .clipShape(size: 12)
            .frame(width: 144, height: 220)
            
            VStack(alignment: .leading, spacing: 4) {
                EventTag(.small)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("AlldayProject")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Label.normal)
                    
                    Text("영서")
                        .font(.caption2(.medium))
                        .foreground(LegacyColor.Label.assistive)
                }
                
//                HStack(spacing: 8) {
//                    StatItem(statType: .heart, text: "999+") { }
//                    StatItem(statType: .flag, text: "108") { }
//                }
            }
            .padding(8)
        }
        .frame(width: 144, height: 220)
    }
}

