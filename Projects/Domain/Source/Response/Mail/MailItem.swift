//
//  MailItem.swift
//  Domain
//
//  Created by 김은찬 on 9/14/25.
//

import Foundation

public struct MailItem: ResponseProtocol {
    public let itemId: Int
    public let itemType: ItemType
    public let itemName: String
    public let itemDescription: String
    public let itemCount: Int
    
    public init(
        itemId: Int,
        itemType: ItemType,
        itemName: String,
        itemDescription: String,
        itemCount: Int
    ) {
        self.itemId = itemId
        self.itemType = itemType
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.itemCount = itemCount
    }
}
