//
//  DailyDataSource.swift
//  Data
//
//  Created by 김은찬 on 10/20/25.
//

import Moya
import Domain

public struct DailyDataSource: DataSourceProtocol {
    public typealias Target = DailyService
    
    public init() {}
    
    public func fetchDaily() async throws -> [DailyResponse] {
        try await performRequest(.fetchDaily)
    }
    
    public func postAward(_ dailyId: Int) async throws -> [InventoryResponse] {
        try await performRequest(.postAward(dailyId))
    }
}
