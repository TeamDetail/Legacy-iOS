//
//  QuizRepositorylmpl.swift
//  Data
//
//  Created by 김은찬 on 7/13/25.
//

import Foundation
import Domain

public struct QuizRepositorylmpl: QuizRepository {
    
    let dataSource: QuizDataSource
    
    public init(dataSource: QuizDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchQuiz(_ id: Int) async throws -> QuizResponse {
        let data = try await dataSource.fetchQuiz(id)
        return data
    }
}
