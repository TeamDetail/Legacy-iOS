//
//  AchievementType+Ext.swift
//  Component
//
//  Created by 김은찬 on 10/21/25.
//

import Domain

public extension AchievementType {
    var icon: LegacyIconography {
        switch self {
        case .ruins: return .achievementRuins
        case .blocks: return .achievementBlocks
        case .card: return .achievementCard
        case .shiningCard: return .achievementShiningCard
        case .cardPack: return .achievementCardPack
        case .clearCourse: return .achievementClearCourse
        case .makeCourse: return .achievementMakeCourse
        case .solveQuiz: return .achievementSolveQuiz
        case .wrongQuiz: return .achievementWrongQuiz
        case .friend: return .achievementFriend
        case .present: return .achievementPresent
        case .sequencePresent: return .achievementSequencePresent
        case .writeComment: return .achievementComment
        case .title: return .achievementTitle
        default: return .emptyImage
        }
    }
}

public extension AchievementGrade {
    var icon: LegacyIconography {
        switch self {
        case .legendary: return .achievementLegendary
        case .epic: return .achievementEpic
        case .unique: return .achievementUnique
        case .challenge: return .achievementChallenge
        case .common: return .achievementCommon
        }
    }
}
