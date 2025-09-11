//
//  ExploreRepositorylmpl.swift
//  Data
//
//  Created by 김은찬 on 6/19/25.
//

import Foundation
import Domain

public struct ExploreRepositoryImpl: ExploreRepository {
    
    let dataSource: ExploreDataSource
    
    public init(dataSource: ExploreDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchMap(_ requst: MapBoundsRequest) async throws -> [RuinsPositionResponse] {
        let data = try await dataSource.fetchRuins(requst)
        return data
    }
    
    public func fetchRuinDeatil(_ id: Int) async throws -> RuinsDetailResponse {
        let data = try await dataSource.fetchRuinDeatil(id)
        return data
    }
    
    public func createBlock(_ request: CreateBlockRequest) async throws -> CreateBlockResponse {
        let data = try await dataSource.createBlock(request)
        return data
    }
    
    public func fetchMyBlock() async throws -> [CreateBlockResponse] {
        let data = try await dataSource.fetchMyBlock()
        return data
    }
    
    public func createComment(_ request: CommentRequest) async throws {
        _ = try await dataSource.createComment(request)
    }
    
    public func fetchComment(_ id: Int) async throws -> [CommentResponse] {
        let data = try await dataSource.fetchComment(id)
        return data
    }
    
    public func searchRuins(_ ruinsName: String) async throws -> [RuinsDetailResponse] {
        let data = try await dataSource.searchRuins(ruinsName)
        return data
    }
}
