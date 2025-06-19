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
    
    public init(provider: MoyaProvider<ExploreService> = MoyaProvider<ExploreService>()) {
        self.provider = provider
    }
    
    public func fetchRuins(_ request: MapBoundsRequest) async throws -> [RuinsPositionResponse] {
        let response: BaseResponse<[RuinsPositionResponse]> = try await self.request(target: .fetchMap(request))
        return response.data
    }
}
