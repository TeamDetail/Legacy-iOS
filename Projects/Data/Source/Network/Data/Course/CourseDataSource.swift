//
//  CourseDataSource.swift
//  Data
//
//  Created by 김은찬 on 8/7/25.
//

import Foundation
import Domain

public struct CourseDataSource: DataSourceProtocol {
    public typealias Target = CourseService
    
    public init() {}
    
    public func fetchCourse() async throws -> [CourseResponse] {
        try await performRequest(.fetchCourse)
    }
    
    public func fetchRecentCourse() async throws -> [CourseResponse] {
        try await performRequest(.fetchRecentCourse)
    }
    
    public func fetchPopularCourse() async throws -> [CourseResponse] {
        try await performRequest(.fetchPopularCourse)
    }
    
    public func fetchEventCourse() async throws -> [CourseResponse] {
        try await performRequest(.fetchEventCourse)
    }
    
    public func likeCourse(_ courseId: Int) async throws -> String {
        try await performRequest(.likeCourse(courseId))
    }
    
    public func fetchCourseDetail(_ courseId: Int) async throws -> CourseDetailResponse {
        try await performRequest(.fetchCourseDetail(courseId))
    }
    
    public func createCourse(_ request: CourseRequest) async throws -> CourseResponse {
        try await performRequest(.createCourse(request))
    }
}
