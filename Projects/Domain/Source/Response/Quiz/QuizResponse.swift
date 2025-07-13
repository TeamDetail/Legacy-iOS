//
//  QuizResponse.swift
//  Domain
//
//  Created by 김은찬 on 7/13/25.
//

import Foundation

public struct QuizResponse: ResponseProtocol {
    public let quizId: Int
    public let quizProblem: String
    public let optionValue: [String]
}
