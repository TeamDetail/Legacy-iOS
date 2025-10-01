//
//  FriendRequestResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/1/25.
//

import Foundation

public struct FriendRequestResponse: ResponseProtocol {
    public let requestId: Int
    public let senderId: Int
    public let receiverId: Int
    public let senderNickname: String
    public let senderProfileImage: String
    public let senderLevel: Int
    public let receiverNickname: String
    public let receiverProfileImage: String
    public let receiverLevel: Int
    public let status: FriendsStatusType
    public let createdAt: String
    
    public init(requestId: Int, senderId: Int, receiverId: Int, senderNickname: String, senderProfileImage: String, senderLevel: Int, receiverNickname: String, receiverProfileImage: String, receiverLevel: Int, status: FriendsStatusType, createdAt: String) {
        self.requestId = requestId
        self.senderId = senderId
        self.receiverId = receiverId
        self.senderNickname = senderNickname
        self.senderProfileImage = senderProfileImage
        self.senderLevel = senderLevel
        self.receiverNickname = receiverNickname
        self.receiverProfileImage = receiverProfileImage
        self.receiverLevel = receiverLevel
        self.status = status
        self.createdAt = createdAt
    }
}

