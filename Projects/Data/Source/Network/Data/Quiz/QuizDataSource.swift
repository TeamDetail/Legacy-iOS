//
//  QuizDataSource.swift
//  Data
//
//  Created by 김은찬 on 7/13/25.
//

import Foundation
import Domain
import Moya

public struct QuizDataSource: DataSourceProtocol {
    public typealias Target = QuizService
    
    public init() {}
    
    public func fetchQuiz(_ id: Int) async throws -> [QuizResponse] {
        try await performRequest(.fetchQuiz(id))
    }
    
    public func checkQuiz(_ request: [CheckQuizRequest]) async throws -> CheckQuizResponse {
        try await performRequest(.checkQuiz(request))
    }
    
    public func fetchHint(_ quizId: Int) async throws -> String {
        try await performRequest(.fetchHint(quizId))
    }
    
    public func fetchQuizCreditCost() async throws -> QuizCreditCostResponse {
        try await performRequest(.fetchQuizCreditCost)
    }
}
