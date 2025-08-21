//
//  StoreResponse.swift
//  Domain
//
//  Created by 김은찬 on 8/21/25.
//

import Foundation

public struct StoreResponse: ResponseProtocol {
    public let cardPack: [CardPack]
    public let buyCount: Int
    
    public init(cardPack: [CardPack], buyCount: Int) {
        self.cardPack = cardPack
        self.buyCount = buyCount
    }
}
