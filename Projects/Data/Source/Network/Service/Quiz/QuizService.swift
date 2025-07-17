//
//  QuizService.swift
//  Data
//
//  Created by 김은찬 on 7/13/25.
//

import Moya
import Domain

public enum QuizService: ServiceProtocol {
    case fetchQuiz(_ id: Int)
    case checkQuiz(_ request: [CheckQuizRequest])
}

extension QuizService {
    public var host: String {
        return "/quiz"
    }
    
    public var path: String {
        switch self {
        case let .fetchQuiz(id): "/\(id)"
        case .checkQuiz: "/check"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchQuiz: .get
        case .checkQuiz: .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchQuiz: .requestPlain
        case let .checkQuiz(request): .requestJSONEncodable(request)
        }
    }
}
