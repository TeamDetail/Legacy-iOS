//
//  AuthRepositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 5/23/25.
//

import Foundation
import Domain

public struct AuthRepositoryImpl: AuthRepository {
    let dataSource: AuthDataSource
    
    public init(dataSource: AuthDataSource) {
        self.dataSource = dataSource
    }
    
    public func postLogin(_ request: AuthRequest) async throws -> TokenResponse {
        return try await dataSource.postLogin(request)
    }
}
