//
//  FriendsDataSource.swift
//  Data
//
//  Created by 김은찬 on 10/1/25.
//

import Moya
import Domain

public struct FriendsDataSource: DataSourceProtocol {
    public typealias Target = FriendsService
    
    public init() {}
    
    //MARK: post
    public func acceptFriend(_ requestId: Int) async throws -> String {
        try await performRequest(.acceptFriend(requestId))
    }
    
    public func refuseFriend(_ requestId: Int) async throws -> String {
        try await performRequest(.refuseFriend(requestId))
    }
    
    public func requestFriend(_ friendCode: String) async throws -> String {
        try await performRequest(.requestFriend(friendCode))
    }
    
    public func requestAutoKakaoFriend(_ Authorization: String) async throws -> String {
        try await performRequest(.requestAutoKakaoFriend(Authorization))
    }
    
    
    //MARK: get
    public func fetchMyCode() async throws -> String {
        try await performRequest(.fetchMyCode)
    }
    
    public func fetchRequestFriend() async throws -> [FriendRequestResponse] {
        try await performRequest(.fetchRequestFriend)
    }
    
    public func fetchSentRequests() async throws -> [FriendRequestResponse] {
        try await performRequest(.fetchSentRequests)
    }
    
    public func fetchMyFriends() async throws -> [FriendsResponse] {
        try await performRequest(.fetchMyFriends)
    }
    
    
    //MARK: delete
    public func deleteFriend(_ friendId: Int) async throws -> String {
        try await performRequest(.deleteFriend(friendId))
    }
    
    public func cancelSentRequest(_ requestId: Int) async throws -> String {
        try await performRequest(.cancelSentRequest(requestId))
    }
    
}
