//
//  CardPack.swift
//  Domain
//
//  Created by 김은찬 on 8/21/25.
//

import Foundation

public struct CardPack: ResponseProtocol {
    public let cardpackName: String
    public let cardpackContent: String
    public let price: Int
    public let storeType: StoreType
    public let cardpackId: Int
    
    public init(cardpackName: String, cardpackContent: String, price: Int, storeType: StoreType, cardpackId: Int) {
        self.cardpackName = cardpackName
        self.cardpackContent = cardpackContent
        self.price = price
        self.storeType = storeType
        self.cardpackId = cardpackId
    }
}
