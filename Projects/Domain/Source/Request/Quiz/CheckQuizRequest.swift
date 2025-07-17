//
//  CheckQuiz.swift
//  Domain
//
//  Created by 김은찬 on 7/17/25.
//

import Foundation

public struct CheckQuizRequest: RequestProtocol {
    public let quizId: Int
    public let answerOption: String
    
    public init(quizId: Int, answerOption: String) {
        self.quizId = quizId
        self.answerOption = answerOption
    }
}
