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
    
    @State private var isHearted: Bool
    @State private var heartCount: Int
    
    public init(data: CourseResponse, action: @escaping () -> Void) {
        self.data = data
        self.action = action
        self._isHearted = State(initialValue: data.heart)
        self._heartCount = State(initialValue: data.heartCount)
    }
    
    public var body: some View {
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
                    .init(color: Color.black.opacity(0.0), location: 0.5),
                    .init(color: Color.black.opacity(0.7), location: 1.0)
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
                    
                    Text(data.description)
                        .font(.caption2(.medium))
                        .foreground(LegacyColor.Label.assistive)
                }
                
                HStack(spacing: 8) {
                    HeartStatItem(
                        isChecked: $isHearted,
                        statType: .heart,
                        text: "\(heartCount)"
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
                        isChecked: data.clear
                    )
                }
            }
            .padding(8)
        }
        .frame(width: 144, height: 220)
    }
}

