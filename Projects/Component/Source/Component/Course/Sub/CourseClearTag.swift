//
//  CourseClearTag.swift
//  Component
//
//  Created by 김은찬 on 8/7/25.
//

import SwiftUI

public struct CourseClearTag: View {
    let current: CGFloat
    private let max: CGFloat = 12
    
    private var progress: CGFloat {
        min(current / max, 1.0)
    }
    
    public init(current: CGFloat) {
        self.current = current
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foreground(LegacyColor.Fill.normal)
                .frame(height: 25)
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height: CGFloat = 25
                let filledWidth = width * progress
                
                if current >= max {
                    RoundedRectangle(cornerRadius: 12)
                        .foreground(LegacyColor.Blue.netural)
                        .frame(width: filledWidth, height: height)
                } else {
                    Rectangle()
                        .foreground(LegacyColor.Blue.netural)
                        .frame(width: filledWidth, height: height)
                        .clipShape(waveClippedShape(width: filledWidth, height: height))
                }
            }
            .clipShape(size: 12)
            .frame(height: 25)
            
            Text(current >= max ? "탐험 완료" : "\(Int(current)) / \(Int(max))")
                .font(.label(.bold))
                .foreground(LegacyColor.Common.white)
                .padding(4)
        }
    }
}

