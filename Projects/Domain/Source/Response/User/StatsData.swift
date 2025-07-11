//
//  StatsData.swift
//  Domain
//
//  Created by 김은찬 on 6/23/25.
//

import Foundation

public struct StatsData: ResponseProtocol {
    public let snowflakeCapacity: Int
    public let storeRestock: Int
    public let creditCollect: Int
    public let dropCount: Int
    
    public init(
        snowflakeCapacity: Int,
        storeRestock: Int,
        creditCollect: Int,
        dropCount: Int
    ) {
        self.snowflakeCapacity = snowflakeCapacity
        self.storeRestock = storeRestock
        self.creditCollect = creditCollect
        self.dropCount = dropCount
    }
}
