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
        let response: BaseResponse<UserInfoResponse> = try await self.request(target: .fetchMyinfo)
        return response.data
    }
    
    public func uploadUrl(_ request: UploadUrlRequest) async throws -> String {
        let response: BaseResponse<String> = try await self.request(target: .uploadUrl(request))
        return response.data
    }
    
    public func changeProfileImage(_ request: ChangeProfileImageRequest) async throws -> UserInfoResponse {
        let response: BaseResponse<UserInfoResponse> = try await self.request(target: .changeProfileImage(request))
        return response.data
    }
}
