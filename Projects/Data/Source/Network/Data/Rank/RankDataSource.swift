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
    
    public func fetchRanking() async throws -> [RankResponse] {
        try await performRequest(.fetchRanking)
    }
}
