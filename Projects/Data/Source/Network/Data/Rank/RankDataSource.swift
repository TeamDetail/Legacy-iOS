//
//  RankDataSource.swift
//  Data
//
//  Created by 김은찬 on 7/19/25.
//

import Foundation
import Domain

public struct RankDataSource: DataSourceProtocol {
    public typealias Target = RankService
    
    public init() {}
    
    public func fetchLevelRanking(_ type: RankType) async throws -> [LevelRankingResponse] {
        try await performRequest(.fetchLevelRanking(type))
    }
    
    public func fetchExploreRanking(_ type: RankType) async throws -> [ExploreRankingResponse] {
        try await performRequest(.fetchExploreRanking(type))
    }
}
