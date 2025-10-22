//
//  QuizRepository.swift
//  Data
//
//  Created by 김은찬 on 7/13/25.
//

import Foundation
import Domain

public protocol QuizRepository {
    func fetchQuiz(_ id: Int) async throws -> [QuizResponse]
    func checkQuiz(_ request: [CheckQuizRequest]) async throws -> CheckQuizResponse
    func fetchHint(_ quizId: Int) async throws -> String
    func fetchQuizCreditCost() async throws -> QuizCreditCostResponse
}
