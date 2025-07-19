//
//  DelayExt.swift
//  Component
//
//  Created by 김은찬 on 7/19/25.
//

import Foundation

public func delayRun(_ delay: TimeInterval, perform action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        action()
    }
}

