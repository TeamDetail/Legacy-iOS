//
//  WaveProgressExt.swift
//  Component
//
//  Created by 김은찬 on 7/9/25.
//

import SwiftUI

public func waveClippedShape(width: CGFloat, height: CGFloat) -> Path {
    var path = Path()
    let cutSize: CGFloat = 20
    path.move(to: .zero)
    path.addLine(to: CGPoint(x: width - cutSize, y: 0))
    path.addLine(to: CGPoint(x: width, y: height))
    path.addLine(to: CGPoint(x: 0, y: height))
    path.closeSubpath()
    return path
}
