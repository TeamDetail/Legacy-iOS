//
//  UserDefaults+Ext.swift
//  Component
//
//  Created by 김은찬 on 12/2/25.
//

import Foundation

extension UserDefaults {
    public static let bgmKey = "isBgmEnabled"
    
    public static var isBgmEnabled: Bool {
        get {
            if UserDefaults.standard.object(forKey: bgmKey) == nil {
                UserDefaults.standard.set(true, forKey: bgmKey)
                return true
            }
            return UserDefaults.standard.bool(forKey: bgmKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: bgmKey)
        }
    }
}

