//
//  ExploreService.swift
//  Data
//
//  Created by 김은찬 on 6/17/25.
//

import Moya
import Domain

public enum ExploreService: ServiceProtocol {
    case fetchMap(_ request: MapBoundsRequest)
    case fetchRuinDeatil(_ id: Int)
    case createBlock(_ request: CreateBlockRequest)
    case fetchMyBlock
    case createComment(_ request: CommentRequest)
    case fetchComment(_ id: Int)
}

extension ExploreService {
    public var host: String {
        switch self {
        case .fetchMap, .fetchRuinDeatil, .createComment, .fetchComment :
            return "/ruins"
        case .createBlock, .fetchMyBlock:
            return "/block"
        }
    }
    
    public var path: String {
        switch self {
        case .fetchMap: "/map"
        case .fetchRuinDeatil(let id): "/\(id)"
        case .createBlock: ""
        case .fetchMyBlock: "/user/me"
        case .createComment: "/comment"
        case .fetchComment(let id): "/comment/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMap: .get
        case .fetchRuinDeatil: .get
        case .createBlock: .post
        case .fetchMyBlock: .get
        case .createComment: .post
        case .fetchComment: .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .fetchMap(request):
            request.toRequestParameters(
                encoding: URLEncoding.default
            )
        case .fetchRuinDeatil(_ ): .requestPlain
        case let .createBlock(request): .requestJSONEncodable(request)
        case .fetchMyBlock: .requestPlain
        case let .createComment(request): .requestJSONEncodable(request)
        case .fetchComment(_ ): .requestPlain
        }
    }
}
