//
//  ProfileDataSource.swift
//  Data
//
//  Created by 김은찬 on 6/23/25.
//

import Moya
import Domain

public struct UserDataSource: DataSourceProtocol {
    public typealias Target = UserService
    
    public init() {}
    
    public func fetchMyinfo() async throws -> UserInfoResponse {
        try await performRequest(.fetchMyinfo)
    }
    
    public func uploadUrl(_ fileName: String) async throws -> ImageUrlResponse {
        try await performRequest(.uploadUrl(fileName))
    }
    
    public func changeProfileImage(_ request: ChangeProfileImageRequest) async throws -> UserInfoResponse {
        try await performRequest(.changeProfileImage(request))
    }
}
