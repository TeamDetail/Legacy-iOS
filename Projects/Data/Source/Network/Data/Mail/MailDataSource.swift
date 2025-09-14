//
//  MailDataSource.swift
//  Data
//
//  Created by 김은찬 on 9/14/25.
//

import Moya
import Domain

public struct MailDataSource: DataSourceProtocol {
    public typealias Target = MailService
    
    public init() {}
    
    public func fetchMail() async throws -> [MailResponse] {
        try await performRequest(.fetchMail)
    }
    
    public func postAward() async throws -> [MailResponse] {
        try await performRequest(.postAward)
    }
}

