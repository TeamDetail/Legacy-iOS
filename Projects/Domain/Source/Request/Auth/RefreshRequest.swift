//
//  RefreshRequest.swift
//  Domain
//
//  Created by 김은찬 on 6/5/25.
//

import Foundation

public struct RefreshRequest: RequestProtocol {
    public let refreshToken: String
    
    public init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
