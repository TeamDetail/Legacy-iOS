//
//  MailRepositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 9/14/25.
//

import Foundation
import Domain

public struct MailRepositoryImpl: MailRepository {
    let dataSource: MailDataSource
    
    public init(dataSource: MailDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchMail() async throws -> [MailResponse] {
        try await dataSource.fetchMail()
    }
    
    public func postAward() async throws -> [MailResponse] {
        try await dataSource.postAward()
    }
}
