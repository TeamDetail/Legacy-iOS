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

//public struct Sign {
//    private static var cachedAccessToken: String?
//    private static var cachedRefreshToken: String?
//    
//    public static func login(
//        accessToken: String,
//        refreshToken: String
//    ) {
//        cachedAccessToken = accessToken
//        cachedRefreshToken = refreshToken
//        UserDefaultsStore.set(accessToken, for: "accessToken")
//        KeychainStore.set(refreshToken, for: "refreshToken")
//    }
//    
//    public static func logout() {
//        cachedAccessToken = nil
//        cachedRefreshToken = nil
//        UserDefaultsStore.delete(key: "accessToken")
//        KeychainStore.delete(key: "refreshToken")
//    }
//    
//    public static func reissue(_ accessToken: String, _ refreshToken: String) {
//        cachedAccessToken = accessToken
//        cachedRefreshToken = refreshToken
//        UserDefaultsStore.set(accessToken, for: "accessToken")
//        KeychainStore.set(refreshToken, for: "refreshToken")
//    }
//    
//    public static var accessToken: String? {
//        cachedAccessToken ?? (try? UserDefaultsStore.read(key: "accessToken"))
//    }
//    
//    public static var refreshToken: String? {
//        cachedRefreshToken ?? (try? KeychainStore.read(key: "refreshToken"))
//    }
//}
