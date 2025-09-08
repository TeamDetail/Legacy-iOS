//
//  CourseDetailResponse.swift
//  Domain
//
//  Created by 김은찬 on 8/28/25.
//

import Foundation

public struct CourseDetailResponse: ResponseProtocol {
    public let courseId: Int
    public let courseName: String
    public let creator: String
    public let tag: [String]
    public let description: String
    public let heartCount: Int
    public let clearCount: Int
    public let eventId: Int?
    public let thumbnail: String
    public let clearRuinsCount: Int
    public let maxRuinsCount: Int
    public let ruins: [ClearRuinsResponse]
    public let clear: Bool
    public let heart: Bool
    
    public init(courseId: Int, courseName: String, creator: String, tag: [String], description: String, heartCount: Int, clearCount: Int, eventId: Int?, thumbnail: String, clearRuinsCount: Int, maxRuinsCount: Int, ruins: [ClearRuinsResponse], clear: Bool, heart: Bool) {
        self.courseId = courseId
        self.courseName = courseName
        self.creator = creator
        self.tag = tag
        self.description = description
        self.heartCount = heartCount
        self.clearCount = clearCount
        self.eventId = eventId
        self.thumbnail = thumbnail
        self.clearRuinsCount = clearRuinsCount
        self.maxRuinsCount = maxRuinsCount
        self.ruins = ruins
        self.clear = clear
        self.heart = heart
    }
}
