//
//  FriendsRepository.swift
//  Domain
//
//  Created by 김은찬 on 10/1/25.
//

import Foundation
import Domain

public protocol FriendsRepository {
    // MARK: - Post
    func acceptFriend(_ requestId: Int) async throws -> String
    func refuseFriend(_ requestId: Int) async throws -> String
    func requestFriend(_ friendCode: String) async throws -> String
    func requestAutoKakaoFriend(_ authorization: String) async throws -> String
    
    // MARK: - Get
    func fetchMyCode() async throws -> String
    func fetchRequestFriend() async throws -> [FriendRequestResponse]
    func fetchSentRequests() async throws -> [FriendRequestResponse]
    func fetchMyFriends() async throws -> [FriendsResponse]
    func searchFriends(_ nickName: String) async throws -> [SearchFriendsResponse]
    
    // MARK: - Delete
    func deleteFriend(_ friendId: Int) async throws -> String
    func cancelSentRequest(_ requestId: Int) async throws -> String
}
