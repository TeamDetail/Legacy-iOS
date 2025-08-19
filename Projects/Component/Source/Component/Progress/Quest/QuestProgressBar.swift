//
//  QuestProgressBar.swift
//  Component
//
//  Created by 김은찬 on 8/19/25.
//

import SwiftUI

public struct QuestProgressBar: View {
    let currentEx: CGFloat
    let maxEx: CGFloat = 500
    
    var progress: CGFloat {
        min(currentEx / maxEx, 1.0)
    }
    
    public init(currentEx: CGFloat) {
        self.currentEx = currentEx
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foreground(LegacyColor.Fill.normal)
                .frame(height: 30)
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height: CGFloat = 40
                let filledWidth = width * progress
                
                Rectangle()
                    .foreground(LegacyColor.Primary.normal)
                    .frame(width: filledWidth, height: height)
                    .clipShape(waveClippedShape(width: filledWidth, height: height))
            }
            .clipShape(size: 20)
            .frame(height: 30)
            
            HStack {
                Text("\(Int(currentEx)) / \(Int(maxEx))")
                    .font(.caption1(.extraBold))
                    .foreground(LegacyColor.Common.white)
            }
            .padding(4)
        }
    }
}
