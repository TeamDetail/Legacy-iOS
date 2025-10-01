//
//  AuthRepository.swift
//  Data
//
//  Created by 김은찬 on 5/23/25.
//

import Foundation
import Domain

public protocol AuthRepository {
    func kakaoLogin(_ request: AuthRequest) async throws -> TokenResponse
    func postReissue(_ request: RefreshRequest) async throws
    func appleLogin(_ requset: AppleLoginRequest) async throws -> TokenResponse
}
