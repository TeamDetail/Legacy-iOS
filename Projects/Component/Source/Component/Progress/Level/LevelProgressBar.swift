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
                    .foreground(LegacyColor.Red.alternative)
                    .frame(width: filledWidth, height: height)
                    .clipShape(waveClippedShape(width: filledWidth, height: height))
            }
            .clipShape(size: 20)
            .frame(height: 40)
            
            HStack(spacing: 4) {
                Text("Lv. \(level)")
                    .font(.headline(.bold))
                    .foreground(LegacyColor.Common.white)
                
                Text("(\(Int(currentExp)) / \(Int(maxExp)))")
                    .font(.caption2(.bold))
                    .foreground(LegacyColor.Label.alternative)
            }
        }
        .padding(.horizontal)
    }
    
    func waveClippedShape(width: CGFloat, height: CGFloat) -> Path {
        var path = Path()
        let cutSize: CGFloat = 20
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: width - cutSize, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        return path
    }
}
