//
//  MailService.swift
//  Data
//
//  Created by 김은찬 on 9/14/25.
//

import Moya
import Domain
import Component

public enum MailService: ServiceProtocol {
    case fetchMail
    case postAward
}

extension MailService {
    public var host: String {
        "/mail"
    }
    
    public var path: String {
        switch self {
        case .fetchMail: ""
        case .postAward: "/allGet"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchMail: .get
        case .postAward: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchMail: .requestPlain
        case .postAward: .requestPlain
        }
    }
}
