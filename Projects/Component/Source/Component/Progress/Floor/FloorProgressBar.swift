//
//  FloorProgressBar.swift
//  Component
//
//  Created by 김은찬 on 7/9/25.
//

import SwiftUI

public struct FloorProgressBar: View {
    let currentFloor: CGFloat
    let maxFloor: CGFloat
    
    var progress: CGFloat {
        min(currentFloor / maxFloor, 1.0)
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
                    .foreground(LegacyColor.Primary.normal)
                    .frame(width: filledWidth, height: height)
                    .clipShape(waveClippedShape(width: filledWidth, height: height))
            }
            .clipShape(size: 20)
            .frame(height: 40)
            
            HStack {
                Text("최고 \(Int(currentFloor))층")
                    .font(.headline(.bold))
                    .foreground(LegacyColor.Common.white)
            }
            .padding(4)
        }
    }
}
