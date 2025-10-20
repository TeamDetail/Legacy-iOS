//
//  DailyRepositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 10/20/25.
//

import Foundation
import Domain

public struct DailyRepositoryImpl: DailyRepository {
    let dataSource: DailyDataSource
    
    public init(dataSource: DailyDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchDaily() async throws -> [DailyResponse] {
        let data = try await dataSource.fetchDaily()
        return data
    }
    
    public func postAward(_ dailyId: Int) async throws -> [InventoryResponse] {
        let data = try await dataSource.postAward(dailyId)
        return data
    }
}
