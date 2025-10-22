//
//  QuizCreditResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/22/25.
//

import Foundation

public struct QuizCreditCostResponse: ResponseProtocol {
    public let currentExploreCount: Int
    public let nextQuizCost: Int
    
    public init(currentExploreCount: Int, nextQuizCost: Int) {
        self.currentExploreCount = currentExploreCount
        self.nextQuizCost = nextQuizCost
    }
}
