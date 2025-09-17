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
    public let imageUrl: String
    public let description: String
    public let credit: Int
    public let level: Int
    public let title: TitleData
    public let record: RecordData
    
    public init(
        userId: Int,
        nickname: String,
        imageUrl: String,
        description: String,
        credit: Int,
        level: Int,
        title: TitleData,
        record: RecordData
    ) {
        self.userId = userId
        self.nickname = nickname
        self.imageUrl = imageUrl
        self.description = description
        self.credit = credit
        self.level = level
        self.title = title
        self.record = record
    }
}
