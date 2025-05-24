//
//  TokenResponse.swift
//  Domain
//
//  Created by 김은찬 on 5/23/25.
//

import Foundation

public struct TokenResponse: ResponseProtocol {
    public let accessToken: String
    public let refreshToken: String
    
    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
