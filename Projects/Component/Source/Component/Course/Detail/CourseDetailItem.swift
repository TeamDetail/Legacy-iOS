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
    let action: () -> Void
    
    @State private var isHearted: Bool
    @State private var heartCount: Int
    
    public init(data: CourseDetailResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
        self._isHearted = State(initialValue: data.heart)
        self._heartCount = State(initialValue: data.heartCount)
    }
    
    public var body: some View {
        VStack {
            if let url = URL(string: data.thumbnail) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
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
                
                VStack {
                    HStack {
                        HeartStatItem(
                            isChecked: $isHearted,
                            statType: .heart,
                            text: "\(heartCount)",
                            size: .big
                        ) {
                            if isHearted {
                                isHearted = false
                                heartCount -= 1
                            } else {
                                isHearted = true
                                heartCount += 1
                            }
                            action()
                        }
                        
                        ClearStatItem(
                            statType: .flag,
                            text: "\(data.clearCount)",
                            isChecked: data.clear,
                            size: .big
                        )
                        
                        Spacer()
                        
                        CourseClearTag(
                            current: CGFloat(data.clearCount)
                        )
                        .frame(width: 84)
                    }
                }
                .padding(.vertical, 8)
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                ForEach(Array(data.ruins.enumerated()), id: \.element) { index, ruinData in
                    CourseDetailClearItem(data: ruinData, index: index)
                }
                .padding(.vertical, 8)
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, 14)
    }
}
