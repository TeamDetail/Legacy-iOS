//
//  ProfileService.swift
//  Data
//
//  Created by 김은찬 on 6/23/25.
//

import Foundation
import Moya
import Domain

public enum UserService: ServiceProtocol {
    case fetchMyinfo
    case uploadUrl(_ fileName: String)
    case changeProfileImage(_ request: ChangeProfileImageRequest)
}

extension UserService {
    public var host: String {
        "/user"
    }
    
    public var path: String {
        switch self {
        case .fetchMyinfo:
            "/me"
        case .uploadUrl:
            "/uploadUrl"
        case .changeProfileImage:
            "/image"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMyinfo: .get
        case .uploadUrl: .get
        case .changeProfileImage: .patch
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchMyinfo:
            return .requestPlain
        case let .uploadUrl(fileName):
            return .requestParameters(
                parameters: ["fileName": fileName],
                encoding: URLEncoding.queryString
            )
        case let .changeProfileImage(request):
            return .requestJSONEncodable(request)
        }
    }
}
