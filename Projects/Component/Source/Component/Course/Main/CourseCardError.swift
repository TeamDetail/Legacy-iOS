//
//  CardError.swift
//  Component
//
//  Created by 김은찬 on 8/7/25.
//

import SwiftUI
import Domain
import Shimmer
import Kingfisher

public struct CourseCardError: View {
    @State private var isPresented = false
    
    public init(isPresented: Bool = false) {
        self.isPresented = isPresented
    }
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 144, height: 220)
                .redacted(reason: .placeholder)
                .shimmering()
            
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
                VStack(alignment: .leading, spacing: 2) {
                    Text("자세히보기")
                        .font(.body2(.bold))
                        .foreground(LegacyColor.Label.normal)
                        .redacted(reason: .placeholder)
                        .shimmering()
                    
                    Text("자세히보기팀 최고")
                        .font(.caption2(.medium))
                        .foreground(LegacyColor.Label.assistive)
                        .redacted(reason: .placeholder)
                        .shimmering()
                }
                
                HStack(spacing: 8) {
                    HeartStatItem(
                        isChecked: $isPresented,
                        statType: .heart,
                        text: ""
                    ) {}
                        .redacted(reason: .placeholder)
                        .shimmering()
                    
                    ClearStatItem(
                        statType: .flag,
                        text: "",
                        isChecked: false
                    )
                    .redacted(reason: .placeholder)
                    .shimmering()
                }
            }
            .padding(8)
        }
        .frame(width: 144, height: 220)
    }
}

