//
//  RankResponse.swift
//  Domain
//
//  Created by 김은찬 on 7/19/25.
//

import Foundation

public struct ExploreRankingResponse: ResponseProtocol {
    public let nickname: String
    public let level: Int
    public let allBlocks: Int
    public let imageUrl: String
    public let title: TitleData
    
    public init(nickname: String, level: Int, allBlocks: Int, imageUrl: String, title: TitleData) {
        self.nickname = nickname
        self.level = level
        self.allBlocks = allBlocks
        self.imageUrl = imageUrl
        self.title = title
    }
}
