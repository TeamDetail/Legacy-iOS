//
//  APIError.swift
//  Domain
//
//  Created by 김은찬 on 9/14/25.
//

public enum APIError: Error {
    case serverMessage(String)
    case invalidResponse
}

public extension APIError {
    var message: String {
        switch self {
        case .serverMessage(let message):
            return message
        case .invalidResponse:
            return "알 수 없는 오류가 발생했어요."
        }
    }
}
