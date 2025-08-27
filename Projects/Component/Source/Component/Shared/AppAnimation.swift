//
//  AppAnimation.swift
//  Component
//
//  Created by 김은찬 on 8/27/25.
//

import SwiftUI

public extension Animation {
    static let appSpring = Animation.spring(
        response: 0.35,
        dampingFraction: 0.75
    )
}
