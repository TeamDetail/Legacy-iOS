//
//  InventoryDataSource.swift
//  Data
//
//  Created by 김은찬 on 9/9/25.
//

import Moya
import Domain

public struct InventoryDataSource: DataSourceProtocol {
    public typealias Target = InventoryService
    
    public init() {}
    
    public func fetchInventory() async throws -> [InventoryResponse] {
        try await performRequest(.fetchInventory)
    }
    
    public func openInventory(_ request: InventoryCardpackRequest) async throws -> [Card] {
        try await performRequest(.openInventory(request))
    }
    
    public func openCredit(_ request: InventoryCreditRequest) async throws -> CreditResponse {
        try await performRequest(.openCredit(request))
    }
}

