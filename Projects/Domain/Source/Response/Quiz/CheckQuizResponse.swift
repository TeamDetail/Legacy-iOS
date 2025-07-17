//
//  CheckQuizResponse.swift
//  Domain
//
//  Created by 김은찬 on 7/17/25.
//

import Foundation

public struct CheckQuizResponse: ResponseProtocol {
    public let blockGiven: Bool
    public let results: [QuizResult]
}
