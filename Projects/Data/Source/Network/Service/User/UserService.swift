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
}

extension UserService {
    public var host: String {
        "/user"
    }
    
    public var path: String {
        switch self {
        case .fetchMyinfo:
            "/me"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMyinfo: .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchMyinfo: .requestPlain
        }
    }
}
