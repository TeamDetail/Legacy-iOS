//
//  CourseItem.swift
//  Component
//
//  Created by 김은찬 on 8/7/25.
//

import SwiftUI
import Domain
import Kingfisher
import Shimmer

public struct CourseItem: View {
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
                if let url = URL(string: data.thumbnail) {
                    KFImage(url)
                        .placeholder { _ in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.3))
                                .frame(maxWidth: .infinity)
                                .frame(height: 180)
                                .redacted(reason: .placeholder)
                                .shimmering()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .clipShape(size: 8)
                    
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.black.opacity(0.0), location: 0.4),
                            .init(color: Color.black.opacity(0.8), location: 0.7),
                            .init(color: Color.black.opacity(1.0), location: 1.0)
                        ]),
                        startPoint: .trailing,
                        endPoint: .leading
                    )
                    .clipShape(size: 8)
                    .frame(height: 180)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        if data.eventId != nil {
                            EventTag(.big)
                        }
                        
                        Text(data.courseName)
                            .font(.title3(.bold))
                            .foreground(LegacyColor.Label.normal)
                        
                        Text(data.description)
                            .font(.label(.regular))
                            .foreground(LegacyColor.Label.netural)
                    }
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
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
                        
                        Spacer()
                        
                        CourseClearTag(
                            current: CGFloat(data.clearCount)
                        )
                        .frame(width: 84)
                    }
                }
                .padding()
            }
        }
    }
}
