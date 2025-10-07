//
//  GoogleLoginRequest.swift
//  Domain
//
//  Created by 김은찬 on 10/7/25.
//

import Foundation

public struct GoogleLoginRequest: RequestProtocol {
    public let idToken: String
    
    public init(idToken: String) {
        self.idToken = idToken
    }
}
