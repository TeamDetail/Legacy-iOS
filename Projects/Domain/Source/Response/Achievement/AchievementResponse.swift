//
//  AchievementResponse.swift
//  Domain
//
//  Created by 김은찬 on 9/16/25.
//

import Foundation

public struct AchievementResponse: ResponseProtocol {
    public let achievementId: Int
    public let achievementName: String
    public let achievementContent: String
    public let achievementType: AchievementType
    public let achieveUserPercent: Double
    public let currentRate: Int
    public let achievementGradeText: String
    public let goalRate: Int
    public let achievementGrade: AchievementGrade
    public let achievementAward: [MailItem]
    public let receive: Bool
    
    public init(achievementId: Int, achievementName: String, achievementContent: String, achievementType: AchievementType, achieveUserPercent: Double, currentRate: Int, achievementGradeText: String, goalRate: Int, achievementGrade: AchievementGrade, achievementAward: [MailItem], receive: Bool) {
        self.achievementId = achievementId
        self.achievementName = achievementName
        self.achievementContent = achievementContent
        self.achievementType = achievementType
        self.achieveUserPercent = achieveUserPercent
        self.currentRate = currentRate
        self.achievementGradeText = achievementGradeText
        self.goalRate = goalRate
        self.achievementGrade = achievementGrade
        self.achievementAward = achievementAward
        self.receive = receive
    }
}
