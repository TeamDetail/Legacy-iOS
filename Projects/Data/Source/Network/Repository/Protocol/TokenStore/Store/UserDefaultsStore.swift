//
//  UserDefaultsStore.swift
//  Data
//
//  Created by 김은찬 on 6/4/25.
//

import Foundation

public struct UserDefaultsStore {
    public static let standard = UserDefaults.standard
    
    public static func set(_ value: String, for key: String) {
        standard.set(value, forKey: key)
    }
    
    public static func read(key: String) throws -> String {
        if let data = standard.string(forKey: key) {
            return data
        } else {
            throw UserDefaultsError.keyDoesNotExist
        }
    }
    
    public static func delete(key: String) {
        standard.removeObject(forKey: key)
    }
}
