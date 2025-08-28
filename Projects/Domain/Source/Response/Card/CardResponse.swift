//
//  CardResponse.swift
//  Domain
//
//  Created by 김은찬 on 7/24/25.
//

import SwiftUI

public struct CardResponse: ResponseProtocol {
    public let maxCount: Int
    public let cards: [Card]
    
    public init(maxCount: Int, cards: [Card]) {
        self.maxCount = maxCount
        self.cards = cards
    }
}
