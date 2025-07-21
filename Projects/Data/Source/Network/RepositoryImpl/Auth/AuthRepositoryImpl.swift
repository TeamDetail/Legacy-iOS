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
        let data = try await dataSource.postLogin(request)
        Sign.login(
            accessToken: data.accessToken,
            refreshToken: data.refreshToken
        )
        return data
    }
    
    public func postReissue(_ request: RefreshRequest) async throws {
        let data = try await dataSource.postReissue(request)
        Sign.reissue(
            data.accessToken,
            data.refreshToken
        )
        print("재발급후\(data.accessToken)")
        print("재발급후\(data.refreshToken)")
    }
}
