//
//  ProfileRepositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 6/23/25.
//

import Foundation
import Domain

public struct UserRepositoryImpl: UserRepository {
    let dataSource: UserDataSource
    
    public init(dataSource: UserDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchMyinfo() async throws -> UserInfoResponse {
        let data = try await dataSource.fetchMyinfo()
        return data
    }
}

