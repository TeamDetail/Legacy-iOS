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
}
