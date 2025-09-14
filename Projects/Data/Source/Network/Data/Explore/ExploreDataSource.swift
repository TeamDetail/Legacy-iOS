//
//  ExploreDataSource.swift
//  Data
//
//  Created by 김은찬 on 6/19/25.
//

import Foundation
import Domain
import Moya

public struct ExploreDataSource: DataSourceProtocol {
    public typealias Target = ExploreService
    
    public init() {}
    
    public func fetchRuins(_ request: MapBoundsRequest) async throws -> [RuinsPositionResponse] {
        try await performRequest(.fetchMap(request))
    }
    
    public func fetchRuinDeatil(_ id: Int) async throws -> RuinsDetailResponse {
        try await performRequest(.fetchRuinDeatil(id))
    }
    
    public func createBlock(_ request: CreateBlockRequest) async throws -> CreateBlockResponse {
        try await performRequest(.createBlock(request))
    }
    
    public func fetchMyBlock() async throws -> [CreateBlockResponse] {
        try await performRequest(.fetchMyBlock)
    }
    
    public func createComment(_ request: CommentRequest) async throws -> CommentResponse {
        try await performRequest(.createComment(request))
    }
    
    public func fetchComment(_ id: Int) async throws -> [CommentResponse] {
        try await performRequest(.fetchComment(id))
    }
    
    public func searchRuins(_ ruinsName: String) async throws -> [RuinsDetailResponse] {
        try await performRequest(.searchRuins(ruinsName))
    }
}
