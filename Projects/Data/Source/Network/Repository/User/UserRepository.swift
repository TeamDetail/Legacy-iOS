//
//  ProfileRepository.swift
//  Data
//
//  Created by 김은찬 on 6/23/25.
//

import Foundation
import Domain

public protocol UserRepository {
    func fetchMyinfo() async throws -> UserInfoResponse
    func uploadUrl(_ fileName: String) async throws -> String
    func changeProfileImage(_ request: ChangeProfileImageRequest) async throws
}

