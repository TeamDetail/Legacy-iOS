//
//  CourseCard.swift
//  Component
//
//  Created by 김은찬 on 7/31/25.
//

import SwiftUI
import Domain
import Shimmer
import Kingfisher

public struct CourseCard: View {
    let data: CourseResponse
    let action: () -> Void
    let navigation: () -> Void
    
    @State private var isHearted: Bool
    @State private var heartCount: Int
    
    public init(data: CourseResponse, action: @escaping () -> Void, navigation: @escaping () -> Void) {
        self.data = data
        self.action = action
        self.navigation = navigation
        self._isHearted = State(initialValue: data.heart)
        self._heartCount = State(initialValue: data.heartCount)
    }
    
    public var body: some View {
        AnimationButton {
            navigation()
        } label: {
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: data.thumbnail))
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
                        .init(color: Color.black.opacity(0.0), location: 0.0),
                        .init(color: Color.black.opacity(0.55), location: 0.75),
                        .init(color: Color.black.opacity(0.75), location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(size: 12)
                .frame(width: 144, height: 220)
                
                VStack(alignment: .leading, spacing: 4) {
                    if data.eventId != nil {
                        EventTag(.small)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(data.courseName)
                            .font(.body2(.bold))
                            .foreground(LegacyColor.Label.normal)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        
                        Text(data.creator)
                            .font(.caption2(.medium))
                            .foreground(LegacyColor.Label.assistive)
                    }
                    
                    HStack(spacing: 8) {
                        HeartStatItem(
                            isChecked: $isHearted,
                            statType: .heart,
                            text: "\(heartCount)",
                            size: .small
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
                            size: .small
                        )
                    }
                }
                .padding(8)
            }
            .frame(width: 144, height: 220)
        }
        .contentShape(Rectangle())
    }
}

