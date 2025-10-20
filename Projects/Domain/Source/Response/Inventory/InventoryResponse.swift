//
//  InventoryResponse.swift
//  Domain
//
//  Created by 김은찬 on 9/9/25.
//

import Foundation

public struct InventoryResponse: ResponseProtocol {
    public let itemId: Int
    public let itemType: StoreType
    public let itemName: String
    public let itemDescription: String
    public let itemCount: Int
    
    public init(itemId: Int, itemType: StoreType, itemName: String, itemDescription: String, itemCount: Int) {
        self.itemId = itemId
        self.itemType = itemType
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.itemCount = itemCount
    }
}
