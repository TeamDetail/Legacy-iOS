//
//  FriendsResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/1/25.
//

import Foundation

public struct FriendsResponse: ResponseProtocol {
    public let userId: Int
    public let nickname: String
    public let profileImage: String
    public let level: Int
    public let friendCode: String
    public let isKakaoFriend: Bool
    public let isMutualFriend: Bool
    
    public init(userId: Int, nickname: String, profileImage: String, level: Int, friendCode: String, isKakaoFriend: Bool, isMutualFriend: Bool) {
        self.userId = userId
        self.nickname = nickname
        self.profileImage = profileImage
        self.level = level
        self.friendCode = friendCode
        self.isKakaoFriend = isKakaoFriend
        self.isMutualFriend = isMutualFriend
    }
}
