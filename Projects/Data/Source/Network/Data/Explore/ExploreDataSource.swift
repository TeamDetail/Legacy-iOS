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
        let response: BaseResponse<[RuinsPositionResponse]> = try await self.request(target: .fetchMap(request))
        return response.data
    }
    
    public func fetchRuinDeatil(_ id: Int) async throws -> RuinsDetailResponse {
        let response: BaseResponse<RuinsDetailResponse> = try await self.request(target: .fetchRuinDeatil(id))
        return response.data
    }
    
    public func createBlock(_ request: CreateBlockRequest) async throws -> CreateBlockResponse {
        let response: BaseResponse<CreateBlockResponse> = try await self.request(target: .createBlock(request))
        return response.data
    }
    
    public func fetchMyBlock() async throws -> [CreateBlockResponse] {
        let response: BaseResponse<[CreateBlockResponse]> = try await self.request(target: .fetchMyBlock)
        return response.data
    }
    
    public func createComment(_ request: CommentRequest) async throws -> CommentResponse {
        let response: BaseResponse<CommentResponse> = try await self.request(target: .createComment(request))
        return response.data
    }
    
    public func fetchComment(_ id: Int) async throws -> [CommentResponse] {
        let response: BaseResponse<[CommentResponse]> = try await self.request(target: .fetchComment(id))
        return response.data
    }
    
    public func searchRuins(_ ruinsName: String) async throws -> [RuinsDetailResponse] {
        let response: BaseResponse<[RuinsDetailResponse]> = try await self.request(target: .searchRuins(ruinsName))
        return response.data
    }
}
