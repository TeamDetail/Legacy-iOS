//
//  LevelProgressBar.swift
//  Component
//
//  Created by 김은찬 on 7/8/25.
//

import SwiftUI

public struct LevelProgressBar: View {
    let level: Int
    let currentExp: CGFloat
    let maxExp: CGFloat
    
    var progress: CGFloat {
        min(currentExp / maxExp, 1.0)
    }
    
    public init(level: Int, currentExp: CGFloat, maxExp: CGFloat) {
        self.level = level
        self.currentExp = currentExp
        self.maxExp = maxExp
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foreground(LegacyColor.Fill.normal)
                .frame(height: 40)
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height: CGFloat = 40
                let filledWidth = width * progress
                
                Rectangle()
                    .foreground(LegacyColor.Red.normal)
                    .frame(width: filledWidth, height: height)
                    .clipShape(waveClippedShape(width: filledWidth, height: height))
            }
            .clipShape(size: 20)
            .frame(height: 40)
            
            HStack(spacing: 8) {
                Text("Lv. \(level)")
                    .font(.headline(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text("(\(Int(currentExp)) / \(Int(maxExp)))")
                    .font(.caption2(.bold))
                    .foreground(LegacyColor.Label.alternative)
            }
        }
    }
}
