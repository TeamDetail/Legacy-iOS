//
//  TabViewIdxEnvironmentKey.swift
//  Component
//
//  Created by 김은찬 on 6/4/25.
//


import SwiftUI

private struct TabViewIdxEnvironmentKey: EnvironmentKey {
    
    static var defaultValue: Int?
}

public extension EnvironmentValues {
    
    var tabViewIdx: Int? {
        get { self [TabViewIdxEnvironmentKey.self] }
        set {
            self [TabViewIdxEnvironmentKey.self] = newValue
        }
    }
}
