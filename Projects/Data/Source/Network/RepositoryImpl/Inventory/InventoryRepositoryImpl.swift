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
        try await dataSource.fetchInventory()
    }
    
    public func openInventory(_ request: InventoryCardpackRequest) async throws -> [Card] {
        try await dataSource.openInventory(request)
    }
    
    public func openCredit(_ request: Domain.InventoryCreditRequest) async throws {
        _ = try await dataSource.openCredit(request)
    }
}
