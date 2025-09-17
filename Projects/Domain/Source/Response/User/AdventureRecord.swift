//
//  AdventureRecord.swift
//  Domain
//
//  Created by 김은찬 on 9/17/25.
//

import Foundation

public struct AdventureRecord: ResponseProtocol {
    public let rank: Int
    public let allBlocks: Int
    public let ruinsBlocks: Int
    public let solvedQuizzes: Int
    public let wrongQuizzes: Int
    public let clearCourse: Int
    public let makeCourse: Int
    public let commentCount: Int
}
