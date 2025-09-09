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
        let response: BaseResponse<[InventoryResponse]> = try await self.request(target: .fetchInventory)
        return response.data
    }
    
    public func openInventory(_ request: InventoryRequest) async throws -> [Card] {
        let response: BaseResponse<[Card]> = try await self.request(target: .openInventory(request))
        return response.data
    }
}

