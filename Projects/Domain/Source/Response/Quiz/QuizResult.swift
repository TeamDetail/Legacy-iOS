//
//  QuizResult.swift
//  Domain
//
//  Created by 김은찬 on 7/17/25.
//

import Foundation

public struct QuizResult: ResponseProtocol {
    public let quizId: Int
    public let isCorrect: Bool
    
    public init(quizId: Int, isCorrect: Bool) {
        self.quizId = quizId
        self.isCorrect = isCorrect
    }
}
