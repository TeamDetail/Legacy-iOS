//
//  UserInfoResponse.swift
//  Domain
//
//  Created by 김은찬 on 6/23/25.
//

import Foundation

public struct UserInfoResponse: ResponseProtocol {
    public let userId: Int
    public let nickname: String
    public let level: Int
    public let exp: Int
    public let credit: Int
    public let stats: StatsData
    public let allBlocks: Int
    public let ruinsBlocks: Int
    public let maxFloor: Int
    public let maxScore: Int
    public let imageUrl: String
    public let title: TitleData
    
    public init
    (userId: Int, nickname: String, level: Int, exp: Int, credit: Int, stats: StatsData, allBlocks: Int, ruinsBlocks: Int, maxFloor: Int, maxScore: Int, imageUrl: String, title: TitleData
    ) {
        self.userId = userId
        self.nickname = nickname
        self.level = level
        self.exp = exp
        self.credit = credit
        self.stats = stats
        self.allBlocks = allBlocks
        self.ruinsBlocks = ruinsBlocks
        self.maxFloor = maxFloor
        self.maxScore = maxScore
        self.imageUrl = imageUrl
        self.title = title
    }
}
