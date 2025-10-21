//
//  InventoryRepository.swift
//  Data
//
//  Created by 김은찬 on 9/9/25.
//

import Foundation
import Domain

public protocol InventoryRepository {
    func fetchInventory() async throws -> [InventoryResponse]
    func openInventory(_ request: InventoryCardpackRequest) async throws -> [Card]
    func openCredit(_ request: InventoryCreditRequest) async throws
}
