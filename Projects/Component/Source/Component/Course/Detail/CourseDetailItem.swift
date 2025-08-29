//
//  CourseDetailItem.swift
//  Component
//
//  Created by 김은찬 on 8/29/25.
//

import SwiftUI
import Domain
import Kingfisher
import Shimmer

public struct CourseDetailItem: View {
    let data: CourseDetailResponse
    public init(data: CourseDetailResponse) {
        self.data = data
    }
    public var body: some View {
        VStack {
            if let url = URL(string: data.thumbnail) {
                KFImage(url)
                    .placeholder { _ in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.3))
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .clipShape(size: 8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(data.creator)
                    .font(.body2(.medium))
                    .foreground(LegacyColor.Label.alternative)
                
                Text(data.courseName)
                    .font(.title1(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text(data.description)
                    .font(.headline(.medium))
                    .foreground(LegacyColor.Label.netural)
                
                HStack {
                    ForEach(data.tag, id:\ .self) { tag in
                        CourseTagItem(tag: tag)
                    }
                }
                .padding(.vertical, 4)
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                ForEach(data.ruins, id: \.self) { data in
                    CourseDetailClearItem(data: data)
                }
                .padding(.vertical, 8)
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, 14)
    }
}
