//
//  AchievementType.swift
//  Domain
//
//  Created by 김은찬 on 9/17/25.
//


public enum AchievementType: String, EnumProtocol, Codable {
    case ruins = "RUINS"
    case blocks = "BLOCKS"
    case card = "CARD"
    case shiningCard = "SHINING_CARD"
    case cardPack = "CARD_PACK"
    case statedCard = "STATED_CARD"
    case level = "LEVEL"
    case clearCourse = "CLEAR_COURSE"
    case makeCourse = "MAKE_COURSE"
    case statedCourse = "STATED_COURSE"
    case solveQuiz = "SOLVE_QUIZ"
    case wrongQuiz = "WRONG_QUIZ"
    case buyItem = "BUY_ITEM"
    case title = "TITLE"
    case friend = "FRIEND"
    case present = "PRESENT"
    case sequencePresent = "SEQUENCE_PRESENT"
}
