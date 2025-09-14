//
//  ServiceProtocol.swift
//  Data
//
//  Created by 김은찬 on 5/22/25.
//

import Foundation
import Moya
import Shared

protocol ServiceProtocol: TargetType {
    
    var host: String { get }
}

extension ServiceProtocol {
    
    public var baseURL: URL {
        .init(string: serverUrl)!
        .appendingPathComponent(host)
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    public var validationType: ValidationType { .none }
}
