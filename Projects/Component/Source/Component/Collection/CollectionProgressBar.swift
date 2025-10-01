//
//  CollectionProgressBar.swift
//  Component
//
//  Created by 김은찬 on 10/1/25.
//

import SwiftUI

public struct CollectionProgressBar: View {
    let cardLength: Int
    let maxCount: Int
    
    var progress: CGFloat {
        guard maxCount > 0 else { return 0 }
        return CGFloat(cardLength) / CGFloat(maxCount)
    }
    
    public init(cardLength: Int, maxCount: Int) {
        self.cardLength = cardLength
        self.maxCount = maxCount
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foreground(LegacyColor.Fill.normal)
                .frame(height: 24)
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height: CGFloat = 40
                let filledWidth = width * progress
                
                Rectangle()
                    .foreground(LegacyColor.Red.normal)
                    .frame(width: filledWidth, height: height)
                    .clipShape(waveClippedShape(width: filledWidth, height: height))
            }
            .clipShape(size: 12)
            .frame(height: 24)
            
            HStack(spacing: 8) {
                Text("\(cardLength) / \(maxCount)")
                    .font(.caption2(.bold))
                    .foreground(LegacyColor.Common.white)
            }
        }
    }
}
