//
//  AdventureKey.swift
//  Component
//
//  Created by 김은찬 on 9/17/25.
//

import Foundation

enum AdventureKey: String, CaseIterable {
    case allBlocks = "탐험 완료한 블록"
    case ruinsBlocks = "탐험 완료한 유적지"
    case solvedQuizzes = "맞춘 퀴즈"
    case wrongQuizzes = "틀린 퀴즈"
    case clearCourse = "완료한 코스"
    case makeCourse = "제작한 코스"
    case commentCount = "남긴 한줄평"
}
