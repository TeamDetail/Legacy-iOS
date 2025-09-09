//
//  InventoryRequest.swift
//  Domain
//
//  Created by 김은찬 on 9/9/25.
//

import Foundation

public struct InventoryRequest: RequestProtocol {
    public let cardpackId: Int
    public let count: Int
    
    public init(cardpackId: Int, count: Int) {
        self.cardpackId = cardpackId
        self.count = count
    }
}
