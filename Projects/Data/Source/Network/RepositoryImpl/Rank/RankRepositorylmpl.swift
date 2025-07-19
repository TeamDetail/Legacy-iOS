//
//  RankRepositorylmpl.swift
//  Data
//
//  Created by 김은찬 on 7/19/25.
//

import Foundation
import Domain

public struct RankRepositorylmpl: RankRepository {
    
    let dataSource: RankDataSource
    
    public init(dataSource: RankDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchRanking() async throws -> [RankResponse] {
        let data = try await dataSource.fetchRanking()
        return data
    }
}
