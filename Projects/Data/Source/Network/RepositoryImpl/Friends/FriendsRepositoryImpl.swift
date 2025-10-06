//
//  FriendsRepositoryImpl.swift
//  Data
//
//  Created by 김은찬 on 10/1/25.
//

import Foundation
import Domain

public struct FriendsRepositoryImpl: FriendsRepository {
    
    let dataSource: FriendsDataSource
    
    public init(dataSource: FriendsDataSource) {
        self.dataSource = dataSource
    }
    
    // MARK: - Post
    public func acceptFriend(_ requestId: Int) async throws -> String {
        try await dataSource.acceptFriend(requestId)
    }
    
    public func refuseFriend(_ requestId: Int) async throws -> String {
        try await dataSource.refuseFriend(requestId)
    }
    
    public func requestFriend(_ friendCode: String) async throws -> String {
        try await dataSource.requestFriend(friendCode)
    }
    
    public func requestAutoKakaoFriend(_ authorization: String) async throws -> String {
        try await dataSource.requestAutoKakaoFriend(authorization)
    }
    
    // MARK: - Get
    public func fetchMyCode() async throws -> String {
        try await dataSource.fetchMyCode()
    }
    
    public func fetchRequestFriend() async throws -> [FriendRequestResponse] {
        try await dataSource.fetchRequestFriend()
    }
    
    public func fetchSentRequests() async throws -> [FriendRequestResponse] {
        try await dataSource.fetchSentRequests()
    }
    
    public func fetchMyFriends() async throws -> [FriendsResponse] {
        try await dataSource.fetchMyFriends()
    }
    
    public func searchFriends(_ nickName: String) async throws -> [SearchFriendsResponse] {
        try await dataSource.searchFriends(nickName)
    }
    
    // MARK: - Delete
    public func deleteFriend(_ friendId: Int) async throws -> String {
        try await dataSource.deleteFriend(friendId)
    }
    
    public func cancelSentRequest(_ requestId: Int) async throws -> String {
        try await dataSource.cancelSentRequest(requestId)
    }
}
