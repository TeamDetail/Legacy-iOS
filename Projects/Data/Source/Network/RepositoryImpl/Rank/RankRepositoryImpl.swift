//
//  RankRepositorylmpl.swift
//  Data
//
//  Created by 김은찬 on 7/19/25.
//

import Foundation
import Domain

public struct RankRepositoryImpl: RankRepository {
    
    let dataSource: RankDataSource
    
    public init(dataSource: RankDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchLevelRanking(_ type: Domain.RankType) async throws -> [RankResponse] {
        try await dataSource.fetchLevelRanking(type)
    }
    
    public func fetchExploreRanking(_ type: Domain.RankType) async throws -> [RankResponse] {
        try await dataSource.fetchExploreRanking(type)
    }
}

