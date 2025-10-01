//
//  AppleLoginRequest.swift
//  Domain
//
//  Created by 김은찬 on 9/30/25.
//

import Foundation

public struct AppleLoginRequest: RequestProtocol {
    public let idToken: String
    public let name: String
    
    public init(idToken: String, name: String) {
        self.idToken = idToken
        self.name = name
    }
}
