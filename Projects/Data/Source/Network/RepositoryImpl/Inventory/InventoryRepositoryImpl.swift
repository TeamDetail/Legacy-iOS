//
//  InventoryRepositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 9/9/25.
//

import Foundation
import Domain

public struct InventoryRepositoryImpl: InventoryRepository {
    let dataSource: InventoryDataSource
    
    public init(dataSource: InventoryDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchInventory() async throws -> [InventoryResponse] {
        let data = try await dataSource.fetchInventory()
        return data
    }
    
    public func openInventory(_ request: InventoryRequest) async throws -> [Card] {
        let data = try await dataSource.openInventory(request)
        return data
    }
}
