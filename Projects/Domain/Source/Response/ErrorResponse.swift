//
//  ErrorResponse.swift
//  Domain
//
//  Created by 김은찬 on 7/21/25.
//

import Foundation

public struct ErrorResponse: ResponseProtocol, Error {
    public let code: String
    public let status: Int
    public let message: String
    
    public init(code: String, status: Int, message: String) {
        self.code = code
        self.status = status
        self.message = message
    }
}
