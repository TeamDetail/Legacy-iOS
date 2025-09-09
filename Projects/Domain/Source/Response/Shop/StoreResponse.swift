//
//  StoreResponse.swift
//  Domain
//
//  Created by 김은찬 on 8/21/25.
//

import Foundation

public struct StoreResponse: ResponseProtocol {
    public let cardpack: [CardPack]
    public let buyCount: Int
    
    public init(cardpack: [CardPack], buyCount: Int) {
        self.cardpack = cardpack
        self.buyCount = buyCount
    }
}
