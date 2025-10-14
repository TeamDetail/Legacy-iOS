//
//  AchievementAwardResponse.swift
//  Domain
//
//  Created by 김은찬 on 10/14/25.
//

import Foundation

public struct AchievementAwardResponse: ResponseProtocol {
    public let awardExp: Int
    public let awardCredit: Int
    public let achievementAward: [MailItem]
    
    public init(
        awardExp: Int,
        awardCredit: Int,
        achievementAward: [MailItem]
    ) {
        self.awardExp = awardExp
        self.awardCredit = awardCredit
        self.achievementAward = achievementAward
    }
}
