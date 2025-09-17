//
//  AdventureProgressBar.swift
//  Component
//
//  Created by 김은찬 on 7/9/25.
//

import SwiftUI

public struct AdventureProgressBar: View {
    let bloackCount: Int
    private let maxBloackCount: CGFloat = 100_000
    
    var progress: CGFloat {
        min(CGFloat(bloackCount) / maxBloackCount, 1.0)
    }
    
    public init(bloackCount: Int) {
        self.bloackCount = bloackCount
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
                    .foreground(LegacyColor.Blue.netural)
                    .frame(width: filledWidth, height: height)
                    .clipShape(waveClippedShape(width: filledWidth, height: height))
            }
            .clipShape(size: 20)
            .frame(height: 40)
            
            HStack {
                Text("총 \(bloackCount)블록 탐험")
                    .font(.headline(.bold))
                    .foreground(LegacyColor.Common.white)
            }
            .padding(4)
        }
    }
}
