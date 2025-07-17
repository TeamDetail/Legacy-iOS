//
//  Sign.swift
//  Data
//
//  Created by 김은찬 on 6/4/25.
//

import Foundation

public struct Sign {
    public static func login(
        accessToken: String,
        refreshToken: String
    ) {
        UserDefaultsStore.set(accessToken, for: "accessToken")
        KeychainStore.set(refreshToken, for: "refreshToken")
    }
    
    public static func logout() {
        UserDefaultsStore.delete(key: "accessToken")
        KeychainStore.delete(key: "refreshToken")
    }
    
    public static func reissue(_ accessToken: String, _ refreshToken: String) {
        UserDefaultsStore.set(accessToken, for: "accessToken")
        KeychainStore.set(refreshToken, for: "refreshToken")
    }
    
    public static var accessToken: String? {
        try? UserDefaultsStore.read(key: "accessToken")
    }
    
    public static var refreshToken: String? {
        try? KeychainStore.read(key: "refreshToken")
    }
}
