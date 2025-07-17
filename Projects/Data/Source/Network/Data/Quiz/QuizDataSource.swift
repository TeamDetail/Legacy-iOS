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
        let response: BaseResponse<[QuizResponse]> = try await self.request(target: .fetchQuiz(id))
        return response.data
    }
    
    public func checkQuiz(_ request: [CheckQuizRequest]) async throws -> CheckQuizResponse {
        let response: BaseResponse<CheckQuizResponse> = try await self.request(target: .checkQuiz(request))
        return response.data
    }
}
