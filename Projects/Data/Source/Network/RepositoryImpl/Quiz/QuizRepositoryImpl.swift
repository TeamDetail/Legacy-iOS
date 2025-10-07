//
//  QuizRepositorylmpl.swift
//  Data
//
//  Created by 김은찬 on 7/13/25.
//

import Foundation
import Domain

public struct QuizRepositoryImpl: QuizRepository {
    
    let dataSource: QuizDataSource
    
    public init(dataSource: QuizDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchQuiz(_ id: Int) async throws -> [QuizResponse] {
        let data = try await dataSource.fetchQuiz(id)
        return data
    }
    
    public func checkQuiz(_ requst: [CheckQuizRequest]) async throws -> CheckQuizResponse {
        let data = try await dataSource.checkQuiz(requst)
        return data
    }
    
    public func fetchHint(_ quizId: Int) async throws -> String {
        let data = try await dataSource.fetchHint(quizId)
        return data
    }
}
