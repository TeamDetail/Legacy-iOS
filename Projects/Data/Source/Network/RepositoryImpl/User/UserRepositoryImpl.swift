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
    
    public func uploadUrl(_ fileName: String) async throws -> ImageUrlResponse {
        let data = try await dataSource.uploadUrl(fileName)
        return data
    }
    
    public func changeProfileImage(_ requst: ChangeProfileImageRequest) async throws {
        _ = try await dataSource.changeProfileImage(requst)
    }
    
    public func fetchTitle() async throws -> [UserTitleResponse] {
        let data = try await dataSource.fetchTitle()
        return data
    }
    
    public func applyTitle(_ styleId: Int) async throws {
        _ = try await dataSource.applyTitle(styleId)
    }
}

