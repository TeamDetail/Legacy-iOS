//
//  CardRespositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 7/24/25.
//

import Foundation
import Domain
import Component

public struct CardRespositoryImpl: CardRepository {
    let dataSource: CardDataSource
    
    public init(dataSource: CardDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchCards(_ region: RegionEnum) async throws -> CardResponse {
        try await dataSource.fetchCards(region)
    }
}
