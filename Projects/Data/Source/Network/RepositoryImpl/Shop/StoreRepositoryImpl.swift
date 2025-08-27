//
//  StoreRepositorylmpl.swift
//  Data
//
//  Created by 김은찬 on 8/21/25.
//

import Foundation
import Domain

public struct StoreRepositoryImpl: StoreRepository {
    let dataSource: StoreDataSource
    
    public init(dataSource: StoreDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchStore() async throws -> StoreResponse {
        let data = try await dataSource.fetchStore()
        return data
    }
}


