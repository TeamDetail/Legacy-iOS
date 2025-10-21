//
//  LevelRankingResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/21/25.
//

import Foundation

public struct LevelRankingResponse: ResponseProtocol {
    public let nickname: String
    public let level: Int
    public let exp: Int
    public let imageUrl: String
    public let title: TitleData
    
    public init(nickname: String, level: Int, exp: Int, imageUrl: String, title: TitleData) {
        self.nickname = nickname
        self.level = level
        self.exp = exp
        self.imageUrl = imageUrl
        self.title = title
    }
}

