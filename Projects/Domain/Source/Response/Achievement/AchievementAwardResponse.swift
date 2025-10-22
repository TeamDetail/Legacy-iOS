//
//  AchievementAwardResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/14/25.
//

import Foundation

public struct AchievementAwardResponse: ResponseProtocol, Decodable {
    public let itemId: Int?
    public let itemType: StoreType?
    public let itemName: String?
    public let itemDescription: String?
    public let itemCount: Int?
    
    public init(itemId: Int? = nil, itemType: StoreType? = nil, itemName: String? = nil, itemDescription: String? = nil, itemCount: Int? = nil) {
        self.itemId = itemId
        self.itemType = itemType
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.itemCount = itemCount
    }
}

