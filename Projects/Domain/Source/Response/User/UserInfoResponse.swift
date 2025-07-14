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
    public let record: RecordData
    public let imageUrl: String
    public let title: TitleData
    
    public init(
        userId: Int,
        nickname: String,
        level: Int, exp: Int,
        credit: Int,
        stats: StatsData,
        record: RecordData,
        imageUrl: String,
        title: TitleData
    ) {
        self.userId = userId
        self.nickname = nickname
        self.level = level
        self.exp = exp
        self.credit = credit
        self.stats = stats
        self.record = record
        self.imageUrl = imageUrl
        self.title = title
    }
}
