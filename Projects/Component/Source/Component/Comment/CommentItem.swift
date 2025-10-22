//
//  CommentItem.swift
//  Component
//
//  Created by 김은찬 on 9/12/25.
//

import SwiftUI
import Domain
import Kingfisher
import Shimmer

public struct CommentItem: View {
    let data: CommentResponse
    
    private var formattedDate: String {
        let trimmed = data.createAt.split(separator: "T").first.map(String.init) ?? data.createAt
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: trimmed) {
            let outputFormatter = DateFormatter()
            outputFormatter.locale = Locale(identifier: "ko_KR")
            outputFormatter.dateFormat = "M월 d일"
            return outputFormatter.string(from: date)
        } else {
            return data.createAt
        }
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                KFImage(URL(string: data.userImgUrl ?? ""))
                    .placeholder { _ in
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipped()
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(data.userName ?? "")
                        .font(.body1(.bold))
                        .foreground(LegacyColor.Common.white)
                    
                    Text(formattedDate)
                        .font(.caption2(.regular))
                        .foreground(LegacyColor.Label.alternative)
                }
            }
            .padding(.vertical, 4)
            
            HStack(spacing: 6) {
                ForEach(0..<5, id: \.self) { index in
                    HStack(spacing: 0) {
                        Image(icon: .leftStar)
                            .resizable()
                            .frame(width: 7, height: 13)
                            .foreground(data.rating >= Double(index) + 0.5 ? LegacyColor.Primary.normal : LegacyColor.Common.white)
                        
                        Image(icon: .rightStar)
                            .resizable()
                            .frame(width: 7, height: 13)
                            .foreground(data.rating >= Double(index) + 1.0 ? LegacyColor.Primary.normal : LegacyColor.Common.white)
                    }
                }
                .foreground(LegacyColor.Common.white)
            }
            
            Text(data.comment)
                .font(.caption2(.regular))
                .foreground(LegacyColor.Common.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
    }
}
