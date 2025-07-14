//
//  RecordData.swift
//  Domain
//
//  Created by 김은찬 on 7/14/25.
//

import Foundation

public struct RecordData: ResponseProtocol {
    public let allBlocks: Int
    public let ruinsBlocks: Int
    public let maxFloor: Int
    public let maxScore: Int
    public let cardCount: Int
    public let shiningCardCount: Int
    
    public init(
        allBlocks: Int,
        ruinsBlocks: Int,
        maxFloor: Int,
        maxScore: Int,
        cardCount: Int,
        shiningCardCount: Int
    ) {
        self.allBlocks = allBlocks
        self.ruinsBlocks = ruinsBlocks
        self.maxFloor = maxFloor
        self.maxScore = maxScore
        self.cardCount = cardCount
        self.shiningCardCount = shiningCardCount
    }
}
