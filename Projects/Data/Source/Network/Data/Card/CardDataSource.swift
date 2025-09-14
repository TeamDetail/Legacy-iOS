//
//  CardDataSource.swift
//  Data
//
//  Created by 김은찬 on 7/24/25.
//

import Moya
import Domain
import Component

public struct CardDataSource: DataSourceProtocol {
    public typealias Target = CardService
    
    public init() {}
    
    public func fetchCards(_ region: RegionEnum) async throws -> CardResponse {
        try await performRequest(.fetchCards(region))
    }
}
