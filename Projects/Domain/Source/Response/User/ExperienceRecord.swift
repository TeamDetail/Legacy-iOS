//
//  ExperienceRecord.swift
//  Domain
//
//  Created by 김은찬 on 9/17/25.
//

import Foundation

public struct ExperienceRecord: ResponseProtocol {
    public let rank: Int
    public let adventureAchieve: Int
    public let experienceAchieve: Int
    public let hiddenAchieve: Int
    public let exp: Int
    public let createdAt: String
    public let titleCount: Int
    public let cardCount: Int
    public let shiningCardCount: Int
}
