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
    case fetchTitle
    case applyTitle(_ styleId: Int)
    case deleteUser
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
        case .fetchTitle:
            "/titles"
        case .applyTitle:
            "/title"
        case .deleteUser:
            ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMyinfo: .get
        case .uploadUrl: .get
        case .changeProfileImage: .patch
        case .fetchTitle: .get
        case .applyTitle: .patch
        case .deleteUser: .delete
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
        case .fetchTitle:
            return .requestPlain
        case let .applyTitle(styleId):
            return .requestParameters(
                parameters: ["styleId": styleId],
                encoding: JSONEncoding.default
            )
        case .deleteUser:
            return .requestPlain
        }
    }
}
