//
//  ErrorCourseDetailItem.swift
//  Component
//
//  Created by 김은찬 on 8/29/25.
//

import SwiftUI
import Domain
import Kingfisher
import Shimmer

public struct ErrorCourseDetailItem: View {
    @State private var error = ["김은찬", "김은찬", "김은찬", "김은찬"]
    public init() {}
    public var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .redacted(reason: .placeholder)
                .shimmering()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("김은찬")
                    .font(.body2(.medium))
                    .foreground(LegacyColor.Label.alternative)
                    .redacted(reason: .placeholder)
                    .shimmering()
                
                Text("대구소프트웨어")
                    .font(.title1(.bold))
                    .foreground(LegacyColor.Common.white)
                    .redacted(reason: .placeholder)
                    .shimmering()
                
                Text("ㅈ같다")
                    .font(.headline(.medium))
                    .foreground(LegacyColor.Label.netural)
                    .redacted(reason: .placeholder)
                    .shimmering()
                
                HStack {
                    ForEach(error, id:\ .self) { tag in
                        CourseTagItem(tag: tag)
                    }
                }
                .redacted(reason: .placeholder)
                .shimmering()
                .padding(.vertical, 4)
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 14)
    }
}

#Preview {
    ErrorCourseDetailItem()
}
