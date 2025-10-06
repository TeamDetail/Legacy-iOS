//
//  SearchFriendsResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/6/25.
//

import Foundation

public struct SearchFriendsResponse: ResponseProtocol {
    public let userId: Int
    public let nickname: String
    public let profileImage: String
    public let level: Int
    public let friendCode: String
    public let isAlreadyFriend: Bool
    
    public init(userId: Int, nickname: String, profileImage: String, level: Int, friendCode: String, isAlreadyFriend: Bool) {
        self.userId = userId
        self.nickname = nickname
        self.profileImage = profileImage
        self.level = level
        self.friendCode = friendCode
        self.isAlreadyFriend = isAlreadyFriend
    }
}
