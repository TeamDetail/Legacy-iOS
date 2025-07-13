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
    
    public let provider: MoyaProvider<QuizService>
    
    public init() {
        self.provider = MoyaProvider<QuizService>(
            session: Moya.Session(interceptor: RemoteInterceptor()),
            plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
        )
    }
    
    public func fetchQuiz(_ id: Int) async throws -> QuizResponse {
        let response: BaseResponse<QuizResponse> = try await self.request(target: .fetchQuiz(id))
        return response.data
    }
}
