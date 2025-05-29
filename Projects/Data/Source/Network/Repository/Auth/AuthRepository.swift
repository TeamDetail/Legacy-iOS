//
//  AuthRepository.swift
//  Data
//
//  Created by 김은찬 on 5/23/25.
//

import Foundation
import Domain

public protocol AuthRepository {
    func postLogin(_ request: AuthRequest) async throws -> TokenResponse
    func postReissue(_ request: AuthRequest) async throws -> TokenResponse
}
