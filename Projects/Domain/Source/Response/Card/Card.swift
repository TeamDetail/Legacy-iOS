//
//  Card.swift
//  Domain
//
//  Created by 김은찬 on 8/18/25.
//

import Foundation

public struct Card: ResponseProtocol {
    public let cardId: Int
    public let cardName: String
    public let cardImageUrl: String
    public let cardType: CardType
    public let nationAttributeName: String
    public let lineAttributeName: String
    public let regionAttributeName: String
    
    public init(cardId: Int, cardName: String, cardImageUrl: String, cardType: CardType, nationAttributeName: String, lineAttributeName: String, regionAttributeName: String) {
        self.cardId = cardId
        self.cardName = cardName
        self.cardImageUrl = cardImageUrl
        self.cardType = cardType
        self.nationAttributeName = nationAttributeName
        self.lineAttributeName = lineAttributeName
        self.regionAttributeName = regionAttributeName
    }
}
