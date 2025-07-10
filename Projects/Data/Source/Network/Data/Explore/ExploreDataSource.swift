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
    
    public let provider: MoyaProvider<ExploreService>
    
    public init() {
        self.provider = MoyaProvider<ExploreService>(
            session: Moya.Session(interceptor: RemoteInterceptor()),
            plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
        )
    }
    
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
}
