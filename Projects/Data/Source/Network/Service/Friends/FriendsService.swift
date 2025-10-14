//
//  FriendsService.swift
//  Data
//
//  Created by 김은찬 on 10/1/25.
//

import Moya
import Domain
import Component

public enum FriendsService: ServiceProtocol {
    //MARK: post
    case acceptFriend(_ requestId: Int)
    case refuseFriend(_ requestId: Int)
    case requestFriend(_ friendCode: String)
    case requestAutoKakaoFriend(_ Authorization: String)
    
    //MARK: get
    case fetchMyCode
    case fetchRequestFriend
    case fetchSentRequests
    case fetchMyFriends
    case searchFriends(_ nickName: String)
    
    //MARK: delete
    case deleteFriend(_ friendId: Int)
    case cancelSentRequest(_ requestId: Int)
}

extension FriendsService {
    public var host: String {
        "/friends"
    }
    
    public var path: String {
        switch self {
            //MARK: post
        case let .acceptFriend(requestId): "request/\(requestId)/accept"
        case let .refuseFriend(requestId): "request/\(requestId)/decline"
        case .requestFriend: "/request"
        case .requestAutoKakaoFriend: "/sync/kakao"
            
            //MARK: get
        case .fetchMyCode: "/my-code"
        case .fetchRequestFriend: "/requests"
        case .fetchSentRequests: "/sent"
        case .fetchMyFriends: ""
        case .searchFriends: "/search"
            
            //MARK: delete
        case let .cancelSentRequest(friendId): "/sent/\(friendId)"
        case let .deleteFriend(friendId): "/\(friendId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .acceptFriend, .refuseFriend, .requestFriend, .requestAutoKakaoFriend:
                .post
        case .fetchMyCode, .fetchRequestFriend, .fetchSentRequests, .fetchMyFriends, .searchFriends:
                .get
        case .deleteFriend, .cancelSentRequest:
                .delete
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .requestFriend(friendCode):
                .requestParameters(
                    parameters: ["friendCode": friendCode],
                    encoding: URLEncoding.queryString
                )
        case let .requestAutoKakaoFriend(Authorization):
                .requestParameters(
                    parameters: ["Authorization": Authorization],
                    encoding: JSONEncoding.default
                )
        case let .searchFriends(nickName):
                .requestParameters(
                    parameters: ["nickname": nickName],
                    encoding: URLEncoding.queryString
                )
        default:
                .requestPlain
        }
    }
}
